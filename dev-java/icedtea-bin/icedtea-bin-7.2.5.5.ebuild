# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/icedtea-bin/icedtea-bin-7.2.5.5.ebuild,v 1.1 2015/05/10 20:45:35 chewi Exp $

EAPI="5"

inherit java-vm-2 multilib prefix versionator

dist="http://dev.gentoo.org/~chewi/distfiles/"
TARBALL_VERSION="${PV}"

DESCRIPTION="A Gentoo-made binary build of the IcedTea JDK"
HOMEPAGE="http://icedtea.classpath.org"
SRC_URI="
	amd64? ( ${dist}/${PN}-core-${TARBALL_VERSION}-amd64.tar.xz )
	x86? ( ${dist}/${PN}-core-${TARBALL_VERSION}-x86.tar.xz )
	doc? ( ${dist}/${PN}-doc-${TARBALL_VERSION}.tar.xz )
	examples? (
		amd64? ( ${dist}/${PN}-examples-${TARBALL_VERSION}-amd64.tar.xz )
		x86? ( ${dist}/${PN}-examples-${TARBALL_VERSION}-x86.tar.xz )
	)
	source? ( ${dist}/${PN}-src-${TARBALL_VERSION}.tar.xz )"

LICENSE="GPL-2-with-linking-exception"
SLOT="7"
KEYWORDS="-* ~amd64 ~x86"

IUSE="+X +alsa cjk +cups doc examples nsplugin pulseaudio selinux source webstart"
REQUIRED_USE="nsplugin? ( X )"
RESTRICT="strip"

# 423161
QA_PREBUILT="opt/.*"

ALSA_COMMON_DEP="
	>=media-libs/alsa-lib-1.0"
CUPS_COMMON_DEP="
	>=net-print/cups-2.0"
X_COMMON_DEP="
		>=dev-libs/atk-2.12
		>=dev-libs/glib-2.40:2
		>=media-libs/fontconfig-2.11:1.0
		>=media-libs/freetype-2.5.3:2
		>=x11-libs/cairo-1.12
		x11-libs/gdk-pixbuf:2
		>=x11-libs/gtk+-2.24:2
		>=x11-libs/libX11-1.6
		>=x11-libs/libXext-1.3
		>=x11-libs/libXi-1.7
		>=x11-libs/libXrender-0.9.4
		>=x11-libs/libXtst-1.2
		>=x11-libs/pango-1.36"

COMMON_DEP="
	>=media-libs/giflib-4.1.6-r1
	>=media-libs/lcms-2.6:2
	media-libs/libpng:0/16
	>=sys-devel/gcc-4.8.4
	>=sys-libs/glibc-2.20
	>=sys-libs/zlib-1.2.3-r1
	virtual/jpeg:62"

# cups is needed for X. #390945 #390975
# gsettings-desktop-schemas is needed for native proxy support. #431972
RDEPEND="${COMMON_DEP}
	X? (
		${CUPS_COMMON_DEP}
		${X_COMMON_DEP}
		media-fonts/dejavu
		cjk? (
			media-fonts/arphicfonts
			media-fonts/baekmuk-fonts
			media-fonts/lklug
			media-fonts/lohit-fonts
			media-fonts/sazanami
		)
	)
	alsa? ( ${ALSA_COMMON_DEP} )
	cups? ( ${CUPS_COMMON_DEP} )
	selinux? ( sec-policy/selinux-java )
	>=gnome-base/gsettings-desktop-schemas-3.12.2"

DEPEND="dev-util/patchelf"

PDEPEND="webstart? ( dev-java/icedtea-web:0[icedtea7] )
	nsplugin? ( dev-java/icedtea-web:0[icedtea7,nsplugin] )
	pulseaudio? ( dev-java/icedtea-sound )"

src_prepare() {
	# Ensures HeadlessGraphicsEnvironment is used.
	if ! use X; then
		rm -r jre/lib/$(get_system_arch)/xawt || die
	fi

	# Reprefixify because prefix may be different.
	sed -i 's:=/:=@GENTOO_PORTAGE_EPREFIX@/:' jre/lib/fontconfig.Gentoo.properties || die
	eprefixify jre/lib/fontconfig.Gentoo.properties

	# Fix the RPATHs.
	# https://bugs.gentoo.org/show_bug.cgi?id=543658#c3
	local old="/usr/$(get_libdir)/icedtea${SLOT}"
	local new="${EPREFIX}/opt/${P}"
	local elf rpath

	for elf in $(find -type f -executable ! -name "*.cgi" || die); do
		rpath=$(patchelf --print-rpath "${elf}" || die "patchelf ${elf}")

		if [[ -n "${rpath}" ]]; then
			patchelf --set-rpath "${rpath//${old}/${new}}" "${elf}" || die "patchelf ${elf}"
		fi
	done
}

src_install() {
	local dest="/opt/${P}"
	local ddest="${ED}${dest#/}"
	dodir "${dest}"

	# doins doesn't preserve executable bits.
	cp -pRP bin include jre lib man "${ddest}" || die

	dodoc doc/{ASSEMBLY_EXCEPTION,AUTHORS,NEWS,README,THIRD_PARTY_README}
	use doc && dodoc -r doc/html

	if use examples; then
		cp -pRP demo sample "${ddest}" || die
	fi

	if use source; then
		cp src.zip "${ddest}" || die
	fi

	if use webstart || use nsplugin; then
		dosym /usr/libexec/icedtea-web/itweb-settings "${dest}/bin/itweb-settings"
		dosym /usr/libexec/icedtea-web/itweb-settings "${dest}/jre/bin/itweb-settings"
	fi
	if use webstart; then
		dosym /usr/libexec/icedtea-web/javaws "${dest}/bin/javaws"
		dosym /usr/libexec/icedtea-web/javaws "${dest}/jre/bin/javaws"
	fi

	set_java_env
	java-vm_revdep-mask "${dest}"
	java-vm_sandbox-predict /proc/self/coredump_filter
}

pkg_postinst() {
	if use nsplugin; then
		if [[ -n ${REPLACING_VERSIONS} ]] && ! version_is_at_least 7.2.4.3 ${REPLACING_VERSIONS} ]]; then
			elog "The nsplugin for icedtea-bin is now provided by the icedtea-web package"
			elog "If you had icedtea-bin-7 nsplugin selected, you may see a related error below"
			elog "The switch should complete properly during the subsequent installation of icedtea-web"
			elog "Afterwards you may verify the output of 'eselect java-nsplugin list' and adjust accordingly'"
		fi
	fi

	# Set as default VM if none exists
	java-vm-2_pkg_postinst
}
