-- Таблица персонажей
CREATE TABLE characters (
  id          TEXT        PRIMARY KEY,
  user_id     UUID        NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  data        JSONB       NOT NULL,
  updated_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Row Level Security: каждый видит только своих персонажей
ALTER TABLE characters ENABLE ROW LEVEL SECURITY;

CREATE POLICY "own_characters" ON characters
  FOR ALL
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- Индекс для быстрой выборки по пользователю
CREATE INDEX idx_characters_user_id ON characters(user_id);
