# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/colordiff/colordiff-1.0.10.ebuild,v 1.6 2012/08/26 17:05:48 armin76 Exp $

EAPI=4

inherit prefix

DESCRIPTION="Colorizes output of diff"
HOMEPAGE="http://colordiff.sourceforge.net/"
#SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
# Hasn't been copied to mirrors yet
SRC_URI="http://${PN}.sourceforge.net/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm ~hppa ia64 ~mips ppc ppc64 sparc x86 ~ppc-aix ~x86-fbsd ~hppa-hpux ~ia64-hpux ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

DEPEND=""
RDEPEND="sys-apps/diffutils"

src_prepare() {
	# set proper etcdir for Gentoo Prefix
	sed -i -e "s:'/etc:'@GENTOO_PORTAGE_EPREFIX@/etc:" "${S}/colordiff.pl" \
		|| die "sed etcdir failed"
	eprefixify "${S}"/colordiff.pl
}

# This package has a makefile, but we don't want to run it
src_compile() { :; }

src_install() {
	newbin ${PN}{.pl,}
	newbin cdiff.sh cdiff
	insinto /etc
	doins colordiffrc colordiffrc-lightbg
	dodoc BUGS CHANGES README TODO
	doman {cdiff,colordiff}.1
}
