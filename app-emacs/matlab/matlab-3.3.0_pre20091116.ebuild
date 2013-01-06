# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/matlab/matlab-3.3.0_pre20091116.ebuild,v 1.3 2012/01/14 18:33:09 armin76 Exp $

inherit elisp

DESCRIPTION="Major modes for MATLAB .m and .tlc files"
HOMEPAGE="http://matlab-emacs.sourceforge.net/"
SRC_URI="http://dev.gentoo.org/~fauli/distfiles/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE=""

DEPEND="app-emacs/cedet"
RDEPEND="${DEPEND}"

SITEFILE=51${PN}-gentoo.el
DOCS="README INSTALL ChangeLog*"
