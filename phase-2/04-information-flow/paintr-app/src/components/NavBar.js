function NavBar({ color, icon, title, description }) {
  return (
    <div className={`ui inverted ${color} menu`}>
      <button className="item">
        <h2 className="ui header">
          <i className={`${icon} icon`} />
          <div className="content">{title}</div>
          <div className="sub header">{description}</div>
        </h2>
      </button>

      {/* Call changeColor() via onClick using props */}
      <button className="ui button">Change Color</button>
    </div>
  );
};

export default NavBar;