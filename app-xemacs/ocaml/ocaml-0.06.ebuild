# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/ocaml/ocaml-0.06.ebuild,v 1.7 2012/06/02 14:52:04 aballier Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Objective Caml editing support."
PKG_CAT="standard"

RDEPEND="app-xemacs/xemacs-base
app-xemacs/fsf-compat
"
KEYWORDS="alpha amd64 hppa ppc ppc64 sparc x86 ~amd64-fbsd"

inherit xemacs-packages
