import GameBoard from "./GameBoard";
import { MovementContextProvider } from "./contexts/MovementContext";
import { getGoldKey, getItemKey } from "./utils/itemSpawn";

console.log("random test", getGoldKey(0), getItemKey(0));

export const App = () => {
  return (
    <div
      style={{
        display: "flex",
        flexDirection: "column",
        alignItems: "center",
        height: "100vh",
        width: "100vw",
      }}
    >
      <MovementContextProvider>
        <GameBoard rows={33} cols={33} />
      </MovementContextProvider>
    </div>
  );
};
