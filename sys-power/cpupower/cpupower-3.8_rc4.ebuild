# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/cpupower/cpupower-3.8_rc4.ebuild,v 1.1 2013/01/23 17:10:15 ssuominen Exp $

EAPI=5
inherit multilib toolchain-funcs

DESCRIPTION="Shows and sets processor power related values"
HOMEPAGE="http://www.kernel.org/"
SRC_URI="mirror://kernel/linux/kernel/v3.0/testing/linux-${PV/_/-}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cpufreq_bench debug nls"

# cpupower should be a USE flag in linux-misc-apps (ditto for usbip!)
# but only if the maintainer doesn't agree to drop it completely from
# there in favour of this one which i'll push to users are replacement
# for the dead cpufreq tools in tree
# !sys-apps/linux-misc-apps[cpupower]
RDEPEND="!sys-apps/linux-misc-apps"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

S=${WORKDIR}/linux-${PV/_/-}/tools/power/${PN}

pkg_setup() {
	myemakeargs=(
		DEBUG=$(usex debug true false)
		V=1
		CPUFREQ_BENCH=$(usex cpufreq_bench true false)
		NLS=$(usex nls true false)
		docdir=/usr/share/doc/${PF}/${PN}
		mandir=/usr/share/man
		libdir=/usr/$(get_libdir)
		AR="$(tc-getAR)"
		CC="$(tc-getCC)"
		LD="$(tc-getCC)"
		STRIP=true
		LDFLAGS="${LDFLAGS}"
		OPTIMIZATION="${CFLAGS}"
		)
}

src_prepare() {
	# -Wl,--as-needed compat
	local libs="-lcpupower -lrt -lpci"
	sed -i \
		-e "/$libs/{ s,${libs},,g; s,\$, ${libs},g;}" \
		-e "s:-O1 -g::" \
		Makefile || die
}

src_compile() {
	emake "${myemakeargs[@]}"
}

src_install() {
	emake DESTDIR="${D}" "${myemakeargs[@]}" install
	dodoc README ToDo
}
