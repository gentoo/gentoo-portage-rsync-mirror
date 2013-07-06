# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/eselect-mode/eselect-mode-1.3.6.ebuild,v 1.1 2013/07/06 14:35:48 ulm Exp $

EAPI=5

inherit elisp

MY_P="eselect-${PV}"
DESCRIPTION="Emacs major mode for editing eselect files"
HOMEPAGE="http://www.gentoo.org/proj/en/eselect/"
SRC_URI="mirror://gentoo/${MY_P}.tar.xz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}/${MY_P}/misc"
SITEFILE="50${PN}-gentoo.el"
