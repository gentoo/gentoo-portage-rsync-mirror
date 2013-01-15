# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/lua-mode/lua-mode-20100617-r1.ebuild,v 1.9 2013/01/15 18:45:55 bicatali Exp $

inherit elisp

DESCRIPTION="An Emacs major mode for editing Lua scripts"
HOMEPAGE="http://lua-users.org/wiki/LuaEditorSupport"
# taken from http://luaforge.net/frs/download.php/4628/lua-mode.el
SRC_URI="mirror://gentoo/${P}.el.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~amd64-linux ~x86-fbsd ~x86-linux"
IUSE=""

SITEFILE="50${PN}-gentoo.el"
