module 0x0::chainpastebin {
    public struct PlainTextStorage has key {
        id: UID,
        text_list: vector<vector<u8>>,
        owner: address
    }

    public fun create_storage(ctx: &mut TxContext) {
        let storage = PlainTextStorage {
            id: object::new(ctx),
            text_list: vector::empty<vector<u8>>(),
            owner: tx_context::sender(ctx),
        };
        transfer::transfer(storage, tx_context::sender(ctx));
    }

    public entry fun add_text(storage: &mut PlainTextStorage, text: vector<u8>, ctx: &TxContext) {
        assert!(tx_context::sender(ctx) == storage.owner, 0);
        vector::push_back(&mut storage.text_list, text);
    }

    public fun get_text_list(storage: &PlainTextStorage): &vector<vector<u8>> {
        &storage.text_list
    }

    public entry fun clear_text_list(storage: &mut PlainTextStorage, ctx: &TxContext) {
        assert!(tx_context::sender(ctx) == storage.owner, 0);
        storage.text_list = vector::empty<vector<u8>>();
    }
}
