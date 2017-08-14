(* Copyright (C) Authors of BuckleScript
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * In addition to the permissions granted to you by the LGPL, you may combine
 * or link a "work that uses the Library" with a publicly distributed version
 * of this file to produce a combined library or application, then distribute
 * that combined work under the terms of your choosing, with no requirement
 * to comply with the obligations normally placed on you by section 4 of the
 * LGPL version 3 (or the corresponding section of a later version of the LGPL
 * should you choose to use a later version).
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA. *)


type rec_flag = 
  | Rec 
  | Non_rec

type function_id = {
  mutable arity : Lam_arity.t;
  lambda  : Lam.t ;
  (* TODO: This may contain some closure environment,
     check how it will interact with dead code elimination
  *)
  rec_flag : rec_flag
}

type element = 
  | NA 
  | SimpleForm of Lam.t 

type boxed_nullable
  = 
  | Undefined 
  | Null 
  | Null_undefined
  | Normal 

type t = 
  | ImmutableBlock of element array * boxed_nullable
  | MutableBlock of element array
  | Constant of Lam.constant
  | Module of Ident.t
        (** TODO: static module vs first class module *)
  | FunctionId of function_id 
  | Exception 
  | Parameter
      (** For this case, it can help us determine whether it should be inlined or not *)

  | NA (** Not such information is associated with an identifier, it is immutable, 
           if you only associate a property to an identifier 
           we should consider [Lassign]
        *)
(** 
       {[ let v/2 =  Pnull_to_opt u]} 

       {[ let v/2 = Pnull_to_opt exp]}
       can be translated into 
       {[
         let v/1 = exp in 
         let v/2 =a Pnull_to_opt exp 
       ]}
       so that [Pfield v/2 0] will be replaced by [v/1], 
       [Lif(v/1)] will be translated into [Lif (v/2 === undefined )]
*)        



val print : Format.formatter -> t -> unit