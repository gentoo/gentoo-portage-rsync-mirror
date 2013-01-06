# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ccs-tools/ccs-tools-1.8.0_p20110214.ebuild,v 1.2 2011/09/29 21:48:40 naota Exp $

EAPI=3
inherit eutils multilib toolchain-funcs

MY_P="${P/_p/-}"
DESCRIPTION="TOMOYO Linux tools"
HOMEPAGE="http://tomoyo.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/tomoyo/49693/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT="test"

DEPEND="sys-libs/ncurses
	sys-libs/readline"
RDEPEND="${DEPEND}
	sys-apps/which"

S="${WORKDIR}/ccstools"

src_prepare() {
	epatch "${FILESDIR}/${P}-parallel.patch"
	epatch "${FILESDIR}/${P}-as-needed.patch"
	epatch "${FILESDIR}/${P}-ldflags.patch"
	sed -i \
		-e "s:gcc:$(tc-getCC):" \
		-e "s/\(CFLAGS.*:=\).*/\1 ${CFLAGS}/" \
		-e "s:/usr/lib:/usr/$(get_libdir):g" \
		-e "s:= /:= ${EPREFIX}/:g" \
		Include.make || die
}

src_test() {
	cd "${S}/kernel_test"
	emake || die
	./testall.sh || die
}

src_install() {
	emake INSTALLDIR="${D}" install || die

#	insinto /etc/ccs
#	doins ccstools.conf || die

	dodoc README.ccs
}

pkg_postinst() {
	elog "Execute the following command to setup the initial policy configuration:"
	elog
	elog "emerge --config =${CATEGORY}/${PF}"
	elog
	elog "For more information, please visit the following."
	elog
	elog "For >=kernel-2.6.36:"
	elog "http://tomoyo.sourceforge.jp/2.3/"
	elog
	elog "For >=kernel-2.6.30:"
	elog "http://tomoyo.sourceforge.jp/2.2/"
	elog
	elog "For <kernel-2.6.30 + ccs-patch:"
	elog "http://tomoyo.sourceforge.jp/1.8/"
}

pkg_config() {
	/usr/$(get_libdir)/ccs/init_policy.sh
}
