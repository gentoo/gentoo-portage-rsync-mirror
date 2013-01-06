# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/u-vm-color/u-vm-color-2.10.ebuild,v 1.4 2008/06/14 23:31:15 ulm Exp $

inherit elisp

DESCRIPTION="Color schemes for VM"
HOMEPAGE="http://ulf.epplejasper.de/EmacsVM.html"
# taken from http://ulf.epplejasper.de/downloads/${PN}.el
SRC_URI="mirror://gentoo/${P}.el.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="app-emacs/vm"
RDEPEND="${DEPEND}"

SITEFILE=51${PN}-gentoo.el
