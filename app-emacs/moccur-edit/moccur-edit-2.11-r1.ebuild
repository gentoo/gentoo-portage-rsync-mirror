# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/moccur-edit/moccur-edit-2.11-r1.ebuild,v 1.2 2008/06/14 23:28:14 ulm Exp $

inherit elisp

DESCRIPTION="An improved interface to color-moccur for editing"
HOMEPAGE="http://www.bookshelf.jp/
	http://www.emacswiki.org/cgi-bin/wiki/SearchBuffers"
# taken from http://www.bookshelf.jp/elc/moccur-edit.el
SRC_URI="mirror://gentoo/${P}.el.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="app-emacs/color-moccur"
DEPEND="${RDEPEND}"

SITEFILE=60${PN}-gentoo.el
