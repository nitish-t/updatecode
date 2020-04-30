package com.app.roadz.recyclerview;


import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;


import java.util.ArrayList;
import java.util.List;

public class DataAdapter extends RecyclerView.Adapter {
    private final int VIEW_ITEM = 1;
    RecyclerView recyclerView;
    private List objectList;

    public int lastCheckedPosition = -1;

    int id_row;

    public DataAdapter(int row_prodect, List sObject_list, RecyclerView recyclerVie) {
        objectList = sObject_list;
        id_row = row_prodect;
        this.recyclerView = recyclerVie;
    }



    @Override
    public int getItemViewType(int position) {
        return VIEW_ITEM;
    }

    @Override
    public RecyclerView.ViewHolder onCreateViewHolder(ViewGroup parent,
                                                      int viewType) {
        RecyclerView.ViewHolder vh;

        View v = LayoutInflater.from(parent.getContext()).inflate(
                id_row, parent, false);

        vh = new ObjectViewHolder(v);

        return vh;
    }

    @Override
    public void onBindViewHolder(RecyclerView.ViewHolder holder, int position) {
        if (holder instanceof ObjectViewHolder) {
            ((ObjectViewHolder) holder).bind(objectList.get(position), position, recyclerView);
        }
    }


    @Override
    public int getItemCount() {
        if (objectList == null) objectList = new ArrayList();
        return objectList.size();
    }

    public void removeAt(int position) {
        objectList.remove(position);
        notifyItemRemoved(position);
        notifyItemRangeChanged(position, objectList.size());
    }

    public List getItem() {
        if (objectList == null)
            objectList = new ArrayList();
        return objectList;
    }

    public Object getItem(int positon) {
        return objectList.get(positon);
    }

    public void setItems(List listItems) {
        if (listItems == null) return;
        objectList = listItems;
        notifyDataSetChanged();
    }

    public void addItems(List listItems) {
        int oldpos = objectList.size() - 1;
        objectList.addAll(listItems);

        notifyDataSetChanged();
    }

    public void addItem(Object Item) {
        objectList.add(Item);

        notifyDataSetChanged();
    }

    public void addItem(int index, Object Item) {
        objectList.add(index, Item);

        notifyDataSetChanged();
    }


    public void setRow(int row_prodect) {
        id_row = row_prodect;
    }


    public static class ObjectViewHolder extends RecyclerView.ViewHolder {

        public View rowView;

        public ObjectViewHolder(View v) {
            super(v);
            rowView = v;

        }

        public void bind(Object object, int position, RecyclerView recyclerView) {

            if (rowView instanceof ViewBinder) {
                ((ViewBinder) rowView).bindViews(object, position, recyclerView);

            } else throw new RuntimeException("view must implements viewbinder interface");
        }
    }


}
