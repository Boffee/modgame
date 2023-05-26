import GameBoard from "./GameBoard";
import { MovementContextProvider } from "./contexts/MovementContext";

export const App = () => {
  return (
    // horizontally and vertically center content and not let content overflow screen
    <div className="flex flex-col items-center justify-center h-screen w-screen overflow-hidden">
      <MovementContextProvider>
        <GameBoard rows={33} cols={33} />
      </MovementContextProvider>
    </div>
  );
};
