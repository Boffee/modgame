import { useComponentValue } from "@latticexyz/react";
import { useMUD } from "./MUDContext";

export const App = () => {
  const {
    components: { Position },
    systemCalls: { move },
    network: { singletonEntity },
  } = useMUD();

  const counter = useComponentValue(Position, singletonEntity);

  return (
    <>
      <div></div>
      <button
        type="button"
        onClick={async (event) => {
          event.preventDefault();
          console.log("new counter value:", await move());
        }}
      >
        Increment
      </button>
    </>
  );
};
