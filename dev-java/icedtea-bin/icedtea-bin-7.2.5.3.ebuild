# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/icedtea-bin/icedtea-bin-7.2.5.3.ebuild,v 1.2 2014/12/05 14:20:35 caster Exp $

EAPI="5"

inherit java-vm-2 multilib prefix versionator

dist="http://dev.gentoo.org/~caster/distfiles/"
TARBALL_VERSION="${PV}"

DESCRIPTION="A Gentoo-made binary build of the IcedTea JDK"
HOMEPAGE="http://icedtea.classpath.org"
SRC_URI="
	amd64? ( ${dist}/${PN}-core-${TARBALL_VERSION}-amd64.tar.bz2 )
	x86? ( ${dist}/${PN}-core-${TARBALL_VERSION}-x86.tar.bz2 )
	doc? ( ${dist}/${PN}-doc-${TARBALL_VERSION}.tar.bz2 )
	examples? (
		amd64? ( ${dist}/${PN}-examples-${TARBALL_VERSION}-amd64.tar.bz2 )
		x86? ( ${dist}/${PN}-examples-${TARBALL_VERSION}-x86.tar.bz2 )
	)
	source? ( ${dist}/${PN}-src-${TARBALL_VERSION}.tar.bz2 )"

LICENSE="GPL-2-with-linking-exception"
SLOT="7"
KEYWORDS="-* ~amd64 ~x86"

IUSE="+X +alsa cjk +cups doc examples nsplugin selinux source webstart"
REQUIRED_USE="nsplugin? ( X )"
RESTRICT="strip"

# 423161
QA_PREBUILT="opt/.*"

ALSA_COMMON_DEP="
	>=media-libs/alsa-lib-1.0.20"
CUPS_COMMON_DEP="
	>=net-print/cups-1.4"
X_COMMON_DEP="
		>=dev-libs/atk-1.30.0
		>=dev-libs/glib-2.20.5:2
		>=media-libs/fontconfig-2.6.0-r2:1.0
		>=media-libs/freetype-2.4.9:2
		>=x11-libs/cairo-1.8.8
		x11-libs/gdk-pixbuf:2
		>=x11-libs/gtk+-2.24:2
		media-libs/lcms:2
		>=x11-libs/libX11-1.4
		>=x11-libs/libXext-1.3
		>=x11-libs/libXi-1.6
		x11-libs/libXrender
		>=x11-libs/libXtst-1.2
		>=x11-libs/pango-1.24.5"

COMMON_DEP="
	>=media-libs/giflib-4.1.6-r1
	>=media-libs/libpng-1.6:0=
	>=sys-devel/gcc-4.5.4
	>=sys-libs/glibc-2.15
	>=sys-libs/zlib-1.2.3-r1
	|| ( virtual/jpeg:62 media-libs/jpeg:62 )"

# cups is needed for X. #390945 #390975
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
	selinux? ( sec-policy/selinux-java )"

PDEPEND="webstart? ( dev-java/icedtea-web:0[icedtea7] )
	nsplugin? ( dev-java/icedtea-web:0[icedtea7,nsplugin] )"

src_install() {
	local dest="/opt/${P}"
	local ddest="${ED}/${dest}"
	dodir "${dest}"

	# Ensures HeadlessGraphicsEnvironment is used.
	if ! use X; then
		rm -r jre/lib/$(get_system_arch)/xawt || die
	fi

	# doins can't handle symlinks.
	cp -pRP bin include jre lib man "${ddest}" || die

	# Remove on next bump as the needed marks are already set by icedtea ebuild.
	java-vm_set-pax-markings "${ddest}"

	dodoc ../doc/{ASSEMBLY_EXCEPTION,THIRD_PARTY_README}

	if use doc; then
		dohtml -r ../doc/html/*
	fi

	if use examples; then
		cp -pRP share/{demo,sample} "${ddest}" || die
	fi

	if use source; then
		cp src.zip "${ddest}" || die
	fi

	# Remove after next bump, handled by icedtea ebuild. Bug 390663
	cp "${FILESDIR}"/fontconfig.Gentoo.properties.src "${T}"/fontconfig.Gentoo.properties || die
	eprefixify "${T}"/fontconfig.Gentoo.properties
	insinto "${dest}"/jre/lib
	doins "${T}"/fontconfig.Gentoo.properties

	if use webstart || use nsplugin; then
		dosym /usr/libexec/icedtea-web/itweb-settings ${dest}/bin/itweb-settings
		dosym /usr/libexec/icedtea-web/itweb-settings ${dest}/jre/bin/itweb-settings
	fi
	if use webstart; then
		dosym /usr/libexec/icedtea-web/javaws ${dest}/bin/javaws
		dosym /usr/libexec/icedtea-web/javaws ${dest}/jre/bin/javaws
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
