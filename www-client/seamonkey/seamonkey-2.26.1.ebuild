# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/seamonkey/seamonkey-2.26.1.ebuild,v 1.2 2014/06/25 14:11:40 axs Exp $

EAPI=5
WANT_AUTOCONF="2.1"

# This list can be updated with scripts/get_langs.sh from the mozilla overlay
MOZ_LANGS=(be ca cs de en en-GB en-US es-AR es-ES fi fr gl hu it ja lt nb-NO nl
	    pl pt-PT ru sk sv-SE tr uk zh-CN zh-TW)

MOZ_PV="${PV/_pre*}"
MOZ_PV="${MOZ_PV/_alpha/a}"
MOZ_PV="${MOZ_PV/_beta/b}"
MOZ_PV="${MOZ_PV/_rc/rc}"
MOZ_P="${P}"
MY_MOZ_P="${PN}-${MOZ_PV}"

if [[ ${PV} == *_pre* ]] ; then
	MOZ_FTP_URI="ftp://ftp.mozilla.org/pub/${PN}/candidates/${MOZ_PV}-candidates/build${PV##*_pre}"
	MOZ_LANGPACK_PREFIX="linux-i686/xpi/"
	# And the langpack stuff stays at eclass defaults
else
	MOZ_FTP_URI="ftp://ftp.mozilla.org/pub/${PN}/releases/${MOZ_PV}"
	MOZ_LANGPACK_PREFIX="langpack/${MY_MOZ_P}."
	MOZ_LANGPACK_SUFFIX=".langpack.xpi"
fi

inherit check-reqs flag-o-matic toolchain-funcs eutils mozconfig-3 multilib pax-utils fdo-mime autotools mozextension nsplugins mozlinguas

PATCHFF="firefox-29.0-patches-0.1"
PATCH="${PN}-2.23-patches-01"
EMVER="1.6.1_pre20140112"

DESCRIPTION="Seamonkey Web Browser"
HOMEPAGE="http://www.seamonkey-project.org"

if [[ ${PV} == *_pre* ]] ; then
	# pre-releases. No need for arch teams to change KEYWORDS here.

	KEYWORDS=""
else
	# This is where arch teams should change the KEYWORDS.

	KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86"
fi

SLOT="0"
LICENSE="MPL-2.0 GPL-2 LGPL-2.1"
IUSE="+chatzilla +crypt gstreamer +ipc +jit minimal pulseaudio +roaming selinux system-cairo system-icu system-jpeg system-sqlite test"

SRC_URI="${SRC_URI}
	${MOZ_FTP_URI}/source/${MY_MOZ_P}.source.tar.bz2 -> ${P}.source.tar.bz2
	http://dev.gentoo.org/~anarchy/mozilla/patchsets/${PATCHFF}.tar.xz
	http://dev.gentoo.org/~polynomial-c/mozilla/patchsets/${PATCH}.tar.xz
	crypt? ( http://dev.gentoo.org/~polynomial-c/mozilla/enigmail-${EMVER}.tar.xz )"
	#crypt? ( http://www.enigmail.net/download/source/enigmail-${EMVER}.tar.gz )

ASM_DEPEND=">=dev-lang/yasm-1.1"

# Mesa 7.10 needed for WebGL + bugfixes
RDEPEND=">=dev-libs/nss-3.16
	>=dev-libs/nspr-4.10.6
	>=dev-libs/glib-2.26:2
	>=media-libs/mesa-7.10
	>=media-libs/libpng-1.6.7[apng]
	>=x11-libs/pango-1.14.0
	>=x11-libs/gtk+-2.14:2
	virtual/libffi
	gstreamer? ( media-plugins/gst-plugins-meta:0.10[ffmpeg] )
	system-cairo? ( >=x11-libs/cairo-1.12[X] x11-libs/pixman )
	system-icu? ( >=dev-libs/icu-51.1 )
	system-jpeg? ( >=media-libs/libjpeg-turbo-1.2.1 )
	system-sqlite? ( >=dev-db/sqlite-3.8.1:3[secure-delete,debug=] )
	>=media-libs/libvpx-1.3.0
	crypt? ( >=app-crypt/gnupg-1.4 )
	kernel_linux? ( media-libs/alsa-lib )
	pulseaudio? ( media-sound/pulseaudio )
	selinux? ( sec-policy/selinux-mozilla )"

DEPEND="${RDEPEND}
	!elibc_glibc? ( !elibc_uclibc? ( dev-libs/libexecinfo ) )
	>=sys-devel/binutils-2.16.1
	virtual/pkgconfig
	amd64? ( ${ASM_DEPEND}
		virtual/opengl )
	x86? ( ${ASM_DEPEND}
		virtual/opengl )"

if [[ ${PV} == *beta* ]] ; then
	S="${WORKDIR}/comm-beta"
else
	S="${WORKDIR}/comm-release"
fi

BUILD_OBJ_DIR="${WORKDIR}/seamonk"

pkg_setup() {
	if [[ ${PV} == *_pre* ]] ; then
		ewarn "You're using an unofficial release of ${PN}. Don't file any bug in"
		ewarn "Gentoo's Bugtracker against this package in case it breaks for you."
		ewarn "Those belong to upstream: https://bugzilla.mozilla.org"
	fi

	moz_pkgsetup
}

pkg_pretend() {
	# Ensure we have enough disk space to compile
	if use debug || use test ; then
		CHECKREQS_DISK_BUILD="8G"
	else
		CHECKREQS_DISK_BUILD="4G"
	fi
	check-reqs_pkg_setup
}

src_unpack() {
	unpack ${A}

	# Unpack language packs
	mozlinguas_src_unpack
}

src_prepare() {
	# Apply our patches
	EPATCH_SUFFIX="patch" \
	EPATCH_FORCE="yes" \
	epatch "${WORKDIR}/seamonkey"

	epatch "${FILESDIR}/pixman-supplement.patch"

	# browser patches go here
	pushd "${S}"/mozilla &>/dev/null || die
	EPATCH_EXCLUDE="2000-firefox_gentoo_install_dirs.patch" \
	EPATCH_SUFFIX="patch" \
	EPATCH_FORCE="yes" \
	epatch "${WORKDIR}/firefox"
	popd &>/dev/null || die
	# drop -Wl,--build-id from LDFLAGS, bug #465466

	# Shell scripts sometimes contain DOS line endings; bug 391889
	grep -rlZ --include="*.sh" $'\r$' . |
	while read -r -d $'\0' file ; do
		einfo edos2unix "${file}"
		edos2unix "${file}"
	done

	if use crypt ; then
		mv "${WORKDIR}"/enigmail "${S}"/mailnews/extensions/enigmail
		#pushd "${S}"/mailnews/extensions/enigmail &>/dev/null || die

		#popd &>/dev/null || die
	fi

	# Allow user to apply any additional patches without modifing ebuild
	epatch_user

	local ms="${S}/mozilla"

	# Enable gnomebreakpad
	if use debug ; then
		sed -i -e "s:GNOME_DISABLE_CRASH_DIALOG=1:GNOME_DISABLE_CRASH_DIALOG=0:g" \
			"${ms}"/build/unix/run-mozilla.sh || die "sed failed!"
	fi

	# Ensure that are plugins dir is enabled as default
	sed -i -e "s:/usr/lib/mozilla/plugins:/usr/lib/nsbrowser/plugins:" \
		"${ms}"/xpcom/io/nsAppFileLocationProvider.cpp || die "sed failed to replace plugin path for 32bit!"
	sed -i -e "s:/usr/lib64/mozilla/plugins:/usr/lib64/nsbrowser/plugins:" \
		"${ms}"/xpcom/io/nsAppFileLocationProvider.cpp || die "sed failed to replace plugin path for 64bit!"

	# Don't exit with error when some libs are missing which we have in
	# system.
	sed '/^MOZ_PKG_FATAL_WARNINGS/s@= 1@= 0@' \
		-i "${S}"/suite/installer/Makefile.in || die
	# Don't error out when there's no files to be removed:
	sed 's@\(xargs rm\)$@\1 -f@' \
		-i "${ms}"/toolkit/mozapps/installer/packager.mk || die

	eautoreconf
	cd "${S}"/mozilla || die
	eautoconf
	cd js/src || die
	eautoconf
}

src_configure() {
	MOZILLA_FIVE_HOME="/usr/$(get_libdir)/${PN}"
	MEXTENSIONS="default"

	####################################
	#
	# mozconfig, CFLAGS and CXXFLAGS setup
	#
	####################################

	mozconfig_init
	mozconfig_config

	# It doesn't compile on alpha without this LDFLAGS
	use alpha && append-ldflags "-Wl,--no-relax"

	if use chatzilla ; then
		MEXTENSIONS+=",irc"
	else
		MEXTENSIONS+=",-irc"
	fi
	if ! use roaming ; then
		MEXTENSIONS+=",-sroaming"
	fi

	# We must force enable jemalloc 3 threw .mozconfig
	echo "export MOZ_JEMALLOC=1" >> ${S}/.mozconfig

	mozconfig_annotate '' --enable-jemalloc
	mozconfig_annotate '' --enable-replace-malloc
	mozconfig_annotate '' --prefix="${EPREFIX}"/usr
	mozconfig_annotate '' --libdir="${EPREFIX}"/usr/$(get_libdir)
	mozconfig_annotate '' --enable-extensions="${MEXTENSIONS}"
	mozconfig_annotate '' --disable-gconf
	mozconfig_annotate '' --enable-jsd
	mozconfig_annotate '' --enable-canvas
	mozconfig_annotate '' --with-system-png
	mozconfig_annotate '' --enable-system-ffi
	mozconfig_annotate '' --disable-gold

	# Other sm-specific settings
	mozconfig_annotate '' --with-default-mozilla-five-home=${MOZILLA_FIVE_HOME}

	mozconfig_annotate '' --target="${CTARGET:-${CHOST}}"
	mozconfig_annotate '' --build="${CTARGET:-${CHOST}}"
	mozconfig_annotate '' --enable-safe-browsing

	mozconfig_use_enable gstreamer
	mozconfig_use_enable pulseaudio
	mozconfig_use_enable system-cairo
	mozconfig_use_enable system-sqlite
	mozconfig_use_with system-jpeg
	mozconfig_use_with system-icu
	mozconfig_use_enable system-icu intl-api
	# Feature is know to cause problems on hardened
	mozconfig_use_enable jit ion

	# Use an objdir to keep things organized.
	echo "mk_add_options MOZ_OBJDIR=${BUILD_OBJ_DIR}" \
		>> "${S}"/.mozconfig

	# Finalize and report settings
	mozconfig_final

	if use crypt ; then
		pushd "${S}"/mailnews/extensions/enigmail &>/dev/null || die
		# econf fails here and would produce useless Makefiles anyway
		./configure || die
		popd &>/dev/null || die
	fi

	# Work around breakage in makeopts with --no-print-directory
	MAKEOPTS="${MAKEOPTS/--no-print-directory/}"

	if [[ $(gcc-major-version) -lt 4 ]] ; then
		append-cxxflags -fno-stack-protector
	elif [[ $(gcc-major-version) -gt 4 || $(gcc-minor-version) -gt 3 ]] ; then
		if use amd64 || use x86 ; then
			append-flags -mno-avx
		fi
	fi
}

src_compile() {
	mkdir -p ${BUILD_OBJ_DIR} && cd ${BUILD_OBJ_DIR} || die

	CC="$(tc-getCC)" CXX="$(tc-getCXX)" LD="$(tc-getLD)" \
	MOZ_MAKE_FLAGS="${MAKEOPTS}" SHELL="${SHELL}" \
	emake -f "${S}/client.mk"

	# Only build enigmail extension if conditions are met.
	if use crypt ; then
		cd "${S}"/mailnews/extensions/enigmail || die
		emake
		emake xpi
	fi
}

src_install() {
	MOZILLA_FIVE_HOME="/usr/$(get_libdir)/${PN}"
	DICTPATH="\"${EPREFIX}/usr/share/myspell\""

	local emid
	cd "${BUILD_OBJ_DIR}" || die

	# Pax mark xpcshell for hardened support, only used for startupcache creation.
	pax-mark m "${BUILD_OBJ_DIR}/mozilla/dist/bin/xpcshell"

	# Copy our preference before omnijar is created.
	sed "s|SEAMONKEY_PVR|${PVR}|" "${FILESDIR}"/all-gentoo-1.js > \
		"${BUILD_OBJ_DIR}/mozilla/dist/bin/defaults/pref/all-gentoo.js" \
		|| die

	# Set default path to search for dictionaries.
	echo "pref(\"spellchecker.dictionary_path\", ${DICTPATH});" \
		>> "${BUILD_OBJ_DIR}/mozilla/dist/bin/defaults/pref/all-gentoo.js" \
		|| die

	if ! use libnotify ; then
		echo 'pref("browser.download.manager.showAlertOnComplete", false);' \
			>> "${BUILD_OBJ_DIR}/mozilla/dist/bin/defaults/pref/all-gentoo.js" \
			|| die
	fi

	echo 'pref("extensions.autoDisableScopes", 3);' >> \
		"${BUILD_OBJ_DIR}/mozilla/dist/bin/defaults/pref/all-gentoo.js" \
		|| die

	MOZ_MAKE_FLAGS="${MAKEOPTS}" \
	emake DESTDIR="${D}" install
	cp "${FILESDIR}"/icon/${PN}.desktop "${T}" || die

	if use crypt ; then
		local em_dir="${S}/mailnews/extensions/enigmail/build"
		pushd "${T}" &>/dev/null || die
		unzip "${em_dir}"/enigmail*.xpi install.rdf || die
		emid=$(sed -n '/<em:id>/!d; s/.*\({.*}\).*/\1/; p; q' install.rdf)

		dodir ${MOZILLA_FIVE_HOME}/extensions/${emid}
		cd "${D}"${MOZILLA_FIVE_HOME}/extensions/${emid} || die
		unzip "${em_dir}"/enigmail*.xpi || die

		popd &>/dev/null || die
	fi

	sed 's|^\(MimeType=.*\)$|\1text/x-vcard;text/directory;application/mbox;message/rfc822;x-scheme-handler/mailto;|' \
		-i "${T}"/${PN}.desktop || die
	sed 's|^\(Categories=.*\)$|\1Email;|' -i "${T}"/${PN}.desktop \
		|| die

	# Install language packs
	mozlinguas_src_install

	# Add StartupNotify=true bug 290401
	if use startup-notification ; then
		echo "StartupNotify=true" >> "${T}"/${PN}.desktop || die
	fi

	# Install icon and .desktop for menu entry
	newicon "${S}"/suite/branding/nightly/content/icon64.png ${PN}.png
	domenu "${T}"/${PN}.desktop

	# Required in order to use plugins and even run seamonkey on hardened.
	pax-mark m "${ED}"${MOZILLA_FIVE_HOME}/{seamonkey,seamonkey-bin,plugin-container}

	if use minimal ; then
		rm -rf "${ED}"/usr/include "${ED}${MOZILLA_FIVE_HOME}"/{idl,include,lib,sdk}
	fi

	# Handle plugins dir through nsplugins.eclass
	share_plugins_dir

	doman "${BUILD_OBJ_DIR}/suite/app/${PN}.1"
}

pkg_preinst() {
	MOZILLA_FIVE_HOME="${ROOT}/usr/$(get_libdir)/${PN}"

	if [ -d ${MOZILLA_FIVE_HOME}/plugins ] ; then
		rm ${MOZILLA_FIVE_HOME}/plugins -rf
	fi
}

pkg_postinst() {
	MOZILLA_FIVE_HOME="/usr/$(get_libdir)/${PN}"

	# Update mimedb for the new .desktop file
	fdo-mime_desktop_database_update

	if use chatzilla ; then
		elog "chatzilla is now an extension which can be en-/disabled and configured via"
		elog "the Add-on manager."
	fi
}
