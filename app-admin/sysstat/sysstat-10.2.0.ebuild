# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/sysstat/sysstat-10.2.0.ebuild,v 1.1 2013/11/04 01:17:02 jer Exp $

EAPI=5
inherit eutils multilib toolchain-funcs

DESCRIPTION="System performance tools for Linux"
HOMEPAGE="http://pagesperso-orange.fr/sebastien.godard/"
SRC_URI="${HOMEPAGE}${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="cron debug +doc isag nls lm_sensors"

RDEPEND="
	cron? ( sys-process/cronbase )
	isag? (
		dev-lang/tk
		dev-vcs/rcs
		sci-visualization/gnuplot
	)
	nls? ( virtual/libintl )
	lm_sensors? ( sys-apps/lm_sensors )
"
DEPEND="
	${RDEPEND}
	nls? ( sys-devel/gettext )
"

src_prepare() {
	if use nls; then
		strip-linguas -i nls/
		local lingua pofile
		for pofile in nls/*.po; do
			lingua=${pofile/nls\/}
			lingua=${lingua/.po}
			if ! has ${lingua} ${LINGUAS}; then
				rm "nls/${lingua}.po" || die
			fi
		done
	fi
	epatch "${FILESDIR}"/${PN}-10.0.4-flags.patch
}

src_configure() {
	tc-export AR
	sa_lib_dir=/usr/$(get_libdir)/sa \
		conf_dir=/etc \
		rcdir=Gentoo-does-not-use-rc.d \
		econf \
			$(use_enable cron install-cron) \
			$(use_enable debug debuginfo) \
			$(use_enable doc documentation ) \
			$(use_enable isag install-isag) \
			$(use_enable lm_sensors sensors) \
			$(use_enable nls)
}

src_compile() {
	emake LFLAGS="${LDFLAGS}"
}

src_install() {
	keepdir /var/log/sa

	use cron && dodir /etc/cron.{daily,hourly}

	emake \
		DESTDIR="${D}" \
		DOC_DIR=/usr/share/doc/${PF} \
		install

	dodoc contrib/sargraph/sargraph

	newinitd "${FILESDIR}"/sysstat.init.d sysstat

	use doc && rm -f "${D}"usr/share/doc/${PF}/COPYING
}
