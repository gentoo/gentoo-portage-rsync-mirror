# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/svn2cl/svn2cl-0.9.ebuild,v 1.2 2014/08/10 21:23:47 slyfox Exp $

inherit eutils

DESCRIPTION="Create a GNU-style ChangeLog from subversion's svn log --xml output"
HOMEPAGE="http://ch.tudelft.nl/~arthur/svn2cl/"
SRC_URI="${HOMEPAGE}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~mips x86"
IUSE=""

RDEPEND="dev-libs/libxslt
	dev-vcs/subversion"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# the wrapper script looks for the xsl files in the
	# same directory as the script.
	epatch "${FILESDIR}"/0.9-wrapper.patch
}

src_install() {
	newbin svn2cl.sh svn2cl || die "failed to install wrapper script"
	insinto /usr/share/svn2cl
	doins svn2cl.xsl svn2html.xsl || die
	dodoc README NEWS TODO ChangeLog authors.xml svn2html.css || die
	doman svn2cl.1 || die
}
pkg_postinst() {
	einfo "You can find samples of svn2html.css and authors.xml in"
	einfo "/usr/share/doc/${PF}/"
	einfo "Read man page for details."
}
