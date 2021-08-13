import { useState } from 'react';

function Painting({ painting }) {

  // Initialize "votes" state
  const [votes, votesSetter] = useState(painting.votes);

  // Breakout Activity #2: Create Function to Add Votes (addVotes)
  // ...
  
  return (
    <div>
      <img src={painting.image} alt=""/>
      <h4>
        "{painting.title}" by {painting.artist.name}
      </h4>
      <p>Year: {painting.date}</p>
      <p>
        Dimensions: {painting.dimensions.width} in. x {painting.dimensions.height} in.
      </p>

      <div className="ui labeled button" tabIndex="0">

      {/* Breakout Activity #2: Call addVotes() via onClick */}
        <div className="ui red button">
          <i className="heart icon"></i> Add Vote
        </div>
        <button className="ui basic red left pointing label">
          {votes}
        </button>
      </div>
    </div>
  );
};

export default Painting;