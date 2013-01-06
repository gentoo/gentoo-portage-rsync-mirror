# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ccs-tools/ccs-tools-1.7.2_p20100401.ebuild,v 1.1 2010/04/04 15:56:43 matsuu Exp $

inherit eutils multilib toolchain-funcs

MY_P="${P/_p/-}"
DESCRIPTION="TOMOYO Linux tools"
HOMEPAGE="http://tomoyo.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/tomoyo/43376/${MY_P}.tar.gz"

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

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e "/^CC=/s:gcc:$(tc-getCC):" \
		-e "/^CFLAGS=/s:-O2:${CFLAGS}:" \
		-e "s:/usr/lib/:/usr/$(get_libdir)/:g" \
		Makefile || die
}

src_test() {
	cd "${S}/kernel_test"
	emake || die
	./testall.sh || die
}

src_install() {
	emake INSTALLDIR="${D}" install || die

	insinto /etc/ccs
	doins ccstools.conf || die

	dodoc README.ccs
}

pkg_postinst() {
	elog "Execute the following command to setup the initial policy configuration:"
	elog
	elog "emerge --config =${CATEGORY}/${PF}"
	elog
	elog "For more information, please visit the following."
	elog
	elog "For >=kernel-2.6.30:"
	elog "http://tomoyo.sourceforge.jp/en/2.2.x/"
	elog
	elog "For <kernel-2.6.30 + ccs-patch:"
	elog "http://tomoyo.sourceforge.jp/en/1.7/"
}

pkg_config() {
	/usr/$(get_libdir)/ccs/init_policy.sh
}
