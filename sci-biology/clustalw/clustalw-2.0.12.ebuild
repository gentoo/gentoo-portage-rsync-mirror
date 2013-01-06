# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/clustalw/clustalw-2.0.12.ebuild,v 1.2 2010/01/01 21:32:10 fauli Exp $

EAPI=2

DESCRIPTION="General purpose multiple alignment program for DNA and proteins"
HOMEPAGE="http://www.clustal.org/"
SRC_URI="http://www.clustal.org/download/current/${P}.tar.gz"

LICENSE="clustalw"
SLOT="2"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~sparc-solaris"
IUSE=""

src_install() {
	einstall || die "Installation failed."
}
