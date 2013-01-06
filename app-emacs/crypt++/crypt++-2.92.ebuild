# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/crypt++/crypt++-2.92.ebuild,v 1.7 2008/05/25 08:27:48 ulm Exp $

inherit elisp

DESCRIPTION="Handle all sorts of compressed and encrypted files"
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki/CryptPlusPlus
	http://freshmeat.net/projects/crypt/"
SRC_URI="mirror://debian/pool/main/c/crypt++el/crypt++el_${PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE=""

S="${WORKDIR}/${PN}el-${PV}"
SITEFILE=50${PN}-gentoo.el
