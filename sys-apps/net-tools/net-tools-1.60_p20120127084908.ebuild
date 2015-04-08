# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/net-tools/net-tools-1.60_p20120127084908.ebuild,v 1.16 2014/01/18 03:28:51 vapier Exp $

EAPI="3"

inherit flag-o-matic toolchain-funcs eutils

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="git://net-tools.git.sourceforge.net/gitroot/net-tools/net-tools"
	inherit git-2
	KEYWORDS=""
else
	PATCH_VER="1"
	SRC_URI="mirror://gentoo/${P}.tar.xz
		mirror://gentoo/${P}-patches-${PATCH_VER}.tar.xz"
	KEYWORDS="alpha amd64 arm arm64 hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~amd64-linux ~arm-linux ~x86-linux"
fi

DESCRIPTION="Standard Linux networking tools"
HOMEPAGE="http://net-tools.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
IUSE="nls old-output static"

RDEPEND="!<sys-apps/openrc-0.9.9.3"
DEPEND="${RDEPEND}
	app-arch/xz-utils"

maint_pkg_create() {
	cd /usr/local/src/net-tools
	#git-update
	local stamp=$(date --date="$(git log -n1 --pretty=format:%ci master)" -u +%Y%m%d%H%M%S)
	local pv="${PV/_p*}_p${stamp}"; pv=${pv/9999/1.60}
	local p="${PN}-${pv}"
	git archive --prefix="nt/" master | tar xf - -C "${T}"
	pushd "${T}" >/dev/null
	pushd nt >/dev/null
	sed -i "/^RELEASE/s:=.*:=${pv}:" Makefile || die
	emake dist >/dev/null
	popd >/dev/null
	zcat ${p}.tar.gz | xz > ${p}.tar.xz
	rm -f ${p}.tar.gz
	popd >/dev/null

	local patches="${p}-patches-${PATCH_VER:-1}"
	local d="${T}/${patches}"
	mkdir "${d}"
	git format-patch -o "${d}" master..gentoo > /dev/null
	echo "From http://git.overlays.gentoo.org/gitweb/?p=proj/net-tools.git" > "${d}"/README
	tar cf - -C "${T}" ${d##*/} | xz > "${T}"/${patches}.tar.xz
	rm -rf "${d}"

	du -b "${T}"/*.tar.xz
}

pkg_setup() { [[ -n ${VAPIER_LOVES_YOU} ]] && maint_pkg_create ; }

set_opt() {
	local opt=$1 ans
	shift
	ans=$("$@" && echo y || echo n)
	einfo "Setting option ${opt} to ${ans}"
	sed -i \
		-e "/^bool.* ${opt} /s:[yn]$:${ans}:" \
		config.in || die
}

src_prepare() {
	if [[ -n ${PATCH_VER} ]] ; then
		use old-output || EPATCH_EXCLUDE="0001-revert-621a2f376334f8097604b9fee5783e0f1141e66d-for-.patch"
		EPATCH_SUFFIX="patch" EPATCH_FORCE="yes" epatch "${WORKDIR}"/${P}-patches-${PATCH_VER}
	fi
}

src_configure() {
	set_opt I18N use nls
	set_opt HAVE_HWIB has_version '>=sys-kernel/linux-headers-2.6'
	set_opt HAVE_HWTR has_version '<sys-kernel/linux-headers-3.5'
	set_opt HAVE_HWSTRIP has_version '<sys-kernel/linux-headers-3.6'
	if use static ; then
		append-flags -static
		append-ldflags -static
	fi
	tc-export AR CC
	yes "" | ./configure.sh config.in || die
}

src_install() {
	emake DESTDIR="${ED}" install || die
	dodoc README README.ipv6 TODO
}

pkg_postinst() {
	einfo "etherwake and such have been split into net-misc/ethercard-diag"
}
