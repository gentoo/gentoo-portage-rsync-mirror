# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/clustalw/clustalw-1.83-r3.ebuild,v 1.2 2010/01/02 18:31:12 fauli Exp $

EAPI="2"

inherit base toolchain-funcs

DESCRIPTION="General purpose multiple alignment program for DNA and proteins"
HOMEPAGE="http://www.embl-heidelberg.de/~seqanal/"
SRC_URI="ftp://ftp.ebi.ac.uk/pub/software/unix/clustalw/${PN}${PV}.UNIX.tar.gz"

LICENSE="clustalw"
SLOT="1"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~sparc-solaris"
IUSE=""

S="${WORKDIR}"/${PN}${PV}

PATCHES=(
	"${FILESDIR}"/${PV}-as-needed.patch
)

src_prepare() {
	base_src_prepare
	sed -i -e "s/CC	= cc/CC	= $(tc-getCC)/" \
		makefile || die
	sed -i -e "s%clustalw_help%/usr/share/doc/${PF}/clustalw_help%" clustalw.c || die
}

src_install() {
	dobin clustalw || die
	dodoc README clustalv.doc clustalw.doc clustalw.ms
	insinto /usr/share/doc/${PF}
	doins clustalw_help
}
