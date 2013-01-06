# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/cvsq/cvsq-0.4.4.ebuild,v 1.2 2012/11/09 18:29:35 ago Exp $

IUSE=""

DESCRIPTION="cvsq is a tool that enables developers with a dial-up connection to work comfortably with CVS by queuing the commits."
SRC_URI="http://metawire.org/~vslavik/sw/cvsq/download/${P}.tar.gz"
HOMEPAGE="http://metawire.org/~vslavik/sw/cvsq/"

SLOT="0"
LICENSE="public-domain"
KEYWORDS="~amd64 ~ppc x86"

DEPEND=""		# This is just a shell script.
RDEPEND="dev-vcs/cvs
		app-shells/bash
		sys-apps/coreutils"

src_install () {
	dodir /usr/bin
	dobin cvsq
	dodoc README AUTHORS ChangeLog
}
