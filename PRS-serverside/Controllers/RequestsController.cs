﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PRS_serverside.Models;

namespace PRS_serverside.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RequestsController : ControllerBase
    {
        private readonly PrsDbContext _context;

        public RequestsController(PrsDbContext context)
        {
            _context = context;
        }

        // GET: api/Requests
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Request>>> GetRequests()
        {
            return await _context.Requests.ToListAsync();
        }

        // GET: api/Requests/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Request>> GetRequest(int id)
        {
            var request = await _context.Requests.FindAsync(id);

            if (request == null)
            {
                return NotFound();
            }

            return request;
        }

        //Get: api/Requests/reviews/{userId}
        //Reads requests for all that have the status "Review" but omitts the users
        [HttpGet("reviews/{userId}")]
        public async Task<ActionResult<IEnumerable<Request>>> GetRequestsInReview(int userId)
        {
            return await (from r in _context.Requests
                          where r.UserId != userId && r.Status == "Review"
                          select r).ToListAsync();

        }

        //PUT: api/requests/review/Id
        //Requests status to Review
        [HttpPut("review/{id}")]
        public async Task<IActionResult> SetRequestToReview(int id, Request request)
        {
            if (request.Total <= 50)
            {
                request.Status = "Approved";
            }
            else
            {
                request.Status = "Review";
            }
            await _context.SaveChangesAsync();
            return Ok();
            
        }

        //PUT: api/request/approve
        //Allows reviewer to set status to approved
        [HttpPut("approve")]
        public async Task<IActionResult> SetRequestToApproved(Request request)
        {
            request.Status = "Approved";
            return await PutRequest(request.Id, request);
        }
        
        //PUT:api/requests/reject
        //Allows reviewer to set status to Rejected
        public async Task<IActionResult> SetRequestToRejected(Request request)
        {
            request.Status = "Rejected";
            await _context.SaveChangesAsync();
            return Ok();

        }
        

        // PUT: api/Requests/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutRequest(int id, Request request)
        {
            if (id != request.Id)
            {
                return BadRequest();
            }

            _context.Entry(request).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!RequestExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/Requests
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<Request>> PostRequest(Request request)
        {
            _context.Requests.Add(request);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetRequest", new { id = request.Id }, request);
        }

        // DELETE: api/Requests/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteRequest(int id)
        {
            var request = await _context.Requests.FindAsync(id);
            if (request == null)
            {
                return NotFound();
            }

            _context.Requests.Remove(request);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool RequestExists(int id)
        {
            return _context.Requests.Any(e => e.Id == id);
        }
    }
}