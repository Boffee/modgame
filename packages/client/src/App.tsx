import GameBoard from "./GameBoard";
import { useMUD } from "./MUDContext";
import { getGoldKey, getItemKey } from "./utils/itemSpawn";

console.log("random test", getGoldKey(0), getItemKey(0));

export const App = () => {
  const {
    systemCalls: { spawn },
  } = useMUD();

  return (
    <>
      <div
        style={{
          // vertically center the game board
          display: "flex",
          flexDirection: "column",
          alignItems: "center",
        }}
      >
        <GameBoard rows={41} cols={41} />
        <button
          type="button"
          onClick={async (event) => {
            event.preventDefault();
            await spawn();
            console.log("spawned");
          }}
        >
          Play
        </button>
      </div>
    </>
  );
};
