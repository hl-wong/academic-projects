import { Platform, StyleSheet, Text, View } from "react-native";
import React from "react";
import { CheckBox } from "react-native-elements";
import Column from "../Column";
import { glob } from "../../assets/styles";
import Row from "../Row";
import FormErrorMessage from "../FormErrorMessage";
import { getFontSize } from "../../utils";

interface CheckboxProps {
  label: string;
  value: boolean;
  onPress?: () => void;
  errors?: string;
}

const Checkbox: React.FC<CheckboxProps> = ({
  label,
  value,
  onPress,
  errors,
}) => {
  return (
    <View>
      <Column>
        <Row style={glob.horizontalCenter}>
          <CheckBox checked={value} onPress={onPress} />
          <Text style={styles.label}>{label}</Text>
        </Row>

        {errors && <FormErrorMessage errors={errors} />}
      </Column>
    </View>
  );
};

export default Checkbox;

const styles = StyleSheet.create({
  label: {
    fontSize: Platform.OS === "ios" ? getFontSize(14) : getFontSize(16),
  },
});
