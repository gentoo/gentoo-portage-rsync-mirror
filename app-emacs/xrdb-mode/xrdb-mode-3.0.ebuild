# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/xrdb-mode/xrdb-mode-3.0.ebuild,v 1.3 2014/03/24 14:57:43 ago Exp $

EAPI=5

inherit elisp

DESCRIPTION="An Emacs major mode for editing X resource database files"
HOMEPAGE="https://launchpad.net/xrdb-mode
	http://www.emacswiki.org/emacs/ResourceFiles"
# taken from https://launchpad.net/${PN}/trunk/3.0/+download/${PN}.el
SRC_URI="http://dev.gentoo.org/~ulm/distfiles/${P}.el.xz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"

SITEFILE="50${PN}-gentoo.el"
