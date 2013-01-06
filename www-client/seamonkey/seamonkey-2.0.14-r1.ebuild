# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/seamonkey/seamonkey-2.0.14-r1.ebuild,v 1.7 2012/07/04 19:20:50 anarchy Exp $

EAPI="2"
WANT_AUTOCONF="2.1"

inherit flag-o-matic toolchain-funcs eutils mozconfig-3 makeedit multilib fdo-mime autotools mozextension java-pkg-opt-2 python

PATCH="${PN}-2.0.11-patches-01"
EMVER="1.0.1"

LANGS="be ca cs de en-GB en-US es-AR es-ES fi fr gl hu it ja ka lt nb-NO nl pl pt-PT ru sk sv-SE tr zh-CN"
NOSHORTLANGS="en-GB es-AR"

MY_PV="${PV/_pre*}"
MY_PV="${MY_PV/_alpha/a}"
MY_PV="${MY_PV/_beta/b}"
MY_PV="${MY_PV/_rc/rc}"
MY_P="${PN}-${MY_PV}"

# release versions usually have language packs. So be careful with changing this.
HAS_LANGS="true"
if [[ ${PV} == *_pre* ]] ; then
	# pre-releases. No need for arch teams to change KEYWORDS here.

	REL_URI="ftp://ftp.mozilla.org/pub/mozilla.org/${PN}/nightly/${MY_PV}-candidates/build${PV##*_pre}"
	KEYWORDS=""
	#HAS_LANGS="false"
else
	# This is where arch teams should change the KEYWORDS.

	REL_URI="http://releases.mozilla.org/pub/mozilla.org/${PN}/releases/${MY_PV}"
	KEYWORDS="alpha arm ia64 ppc64 sparc"
	[[ ${PV} == *alpha* ]] && HAS_LANGS="false"
fi

DESCRIPTION="Seamonkey Web Browser"
HOMEPAGE="http://www.seamonkey-project.org"

SLOT="0"
LICENSE="MPL-1.1 GPL-2 LGPL-2.1"
IUSE="+alsa +chatzilla +composer +crypt gnome java ldap +mailclient +roaming system-sqlite"

SRC_URI="${REL_URI}/source/${MY_P}.source.tar.bz2
	http://dev.gentoo.org/~polynomial-c/mozilla/patchsets/${PATCH}.tar.bz2
	crypt? ( mailclient? ( http://www.mozilla-enigmail.org/download/source/enigmail-${EMVER}.tar.gz ) )"

if ${HAS_LANGS} ; then
	for X in ${LANGS} ; do
		if [ "${X}" != "en" ] && [ "${X}" != "en-US" ]; then
			SRC_URI="${SRC_URI}
				linguas_${X/-/_}? ( ${REL_URI}/langpack/${MY_P}.${X}.langpack.xpi -> ${MY_P}-${X}.xpi )"
		fi
		IUSE="${IUSE} linguas_${X/-/_}"
		# english is handled internally
		if [ "${#X}" == 5 ] && ! has ${X} ${NOSHORTLANGS}; then
			if [ "${X}" != "en-US" ]; then
				SRC_URI="${SRC_URI}
					linguas_${X%%-*}? ( ${REL_URI}/langpack/${MY_P}.${X}.langpack.xpi -> ${MY_P}-${X}.xpi )"
			fi
			IUSE="${IUSE} linguas_${X%%-*}"
		fi
	done
fi

RDEPEND="java? ( virtual/jre )
	>=sys-devel/binutils-2.16.1
	>=dev-libs/nss-3.12.8
	>=dev-libs/nspr-4.8.6
	alsa? ( media-libs/alsa-lib )
	system-sqlite? ( >=dev-db/sqlite-3.6.22-r2[fts3,secure-delete] )
	>=app-text/hunspell-1.2
	>=x11-libs/gtk+-2.10.0:2
	>=x11-libs/pango-1.14.0[X]
	crypt? ( mailclient? ( >=app-crypt/gnupg-1.4 ) )
	gnome? ( >=gnome-base/gnome-vfs-2.16.3
		>=gnome-base/libgnomeui-2.16.1
		>=gnome-base/gconf-2.16.0
		>=gnome-base/libgnome-2.16.0 )"

DEPEND="${RDEPEND}
	=dev-lang/python-2*[threads]
	virtual/pkgconfig
	java? ( >=virtual/jdk-1.4 )"

S="${WORKDIR}/comm-1.9.1"

linguas() {
	local LANG SLANG
	for LANG in ${LINGUAS}; do
		if has ${LANG} en en_US; then
			has en ${linguas} || linguas="${linguas:+"${linguas} "}en"
			continue
		elif has ${LANG} ${LANGS//-/_}; then
			has ${LANG//_/-} ${linguas} || linguas="${linguas:+"${linguas} "}${LANG//_/-}"
			continue
		elif [[ " ${LANGS} " == *" ${LANG}-"* ]]; then
			for X in ${LANGS}; do
				if [[ "${X}" == "${LANG}-"* ]] && \
					[[ " ${NOSHORTLANGS} " != *" ${X} "* ]]; then
					has ${X} ${linguas} || linguas="${linguas:+"${linguas} "}${X}"
					continue 2
				fi
			done
		fi
		ewarn "Sorry, but ${PN} does not support the ${LANG} LINGUA"
	done
}

src_unpack() {
	unpack ${A}

	if ${HAS_LANGS} ; then
		linguas
		for X in ${linguas}; do
			# FIXME: Add support for unpacking xpis to portage
			[[ ${X} != "en" ]] && xpi_unpack "${MY_P}-${X}.xpi"
		done
		if [[ ${linguas} != "" && ${linguas} != "en" ]]; then
			einfo "Selected language packs (first will be default): ${linguas}"
		fi
	fi
}

pkg_setup() {
	if [[ ${PV} == *_pre* ]] ; then
		ewarn "You're using an unofficial release of ${PN}. Don't file any bug in"
		ewarn "Gentoo's Bugtracker against this package in case it breaks for you."
		ewarn "Those belong to upstream: https://bugzilla.mozilla.org"
	fi

	# Ensure we always build with C locale.
	export LANG="C"
	export LC_ALL="C"
	export LC_MESSAGES="C"
	export LC_CTYPE="C"

	export BUILD_OFFICIAL=1
	export MOZILLA_OFFICIAL=1

	java-pkg-opt-2_pkg_setup

	python_set_active_version 2
}

src_prepare() {
	java-pkg-opt-2_src_prepare

	# Apply our patches
	EPATCH_EXCLUDE="1008-seamonkey-cups-1.4.4-fixup.patch" \
	EPATCH_SUFFIX="patch" \
	EPATCH_FORCE="yes" \
	epatch "${WORKDIR}/patch"

	epatch "${FILESDIR}"/${PN}-2.0.14-curl7217-includes-fix.patch

	if use crypt && use mailclient ; then
		mv "${WORKDIR}"/enigmail "${S}"/mailnews/extensions/enigmail
		cd "${S}"/mailnews/extensions/enigmail || die
		epatch "${FILESDIR}"/enigmail/70_enigmail-fix.patch
		makemake2
		cd "${S}"
	fi

	eautoreconf
}

src_configure() {
	declare MOZILLA_FIVE_HOME="/usr/$(get_libdir)/${PN}"
	MEXTENSIONS=""

	####################################
	#
	# mozconfig, CFLAGS and CXXFLAGS setup
	#
	####################################

	mozconfig_init
	mozconfig_config

	# seamonkey has issues with >=x11-libs/cairo-1.10.0 (bug #337813).
	# If you don't like this blame upstream as they don't care about
	# anything than their damned bundled shit!!!
	sed '/--enable-system-cairo/s:enable:disable:' -i "${S}"/.mozconfig \
		|| die

	# It doesn't compile on alpha without this LDFLAGS
	use alpha && append-ldflags "-Wl,--no-relax"

	if ! use chatzilla ; then
		MEXTENSIONS="${MEXTENSIONS},-irc"
	fi
	if ! use roaming ; then
		MEXTENSIONS="${MEXTENSIONS},-sroaming"
	fi

	if ! use gnome ; then
		MEXTENSIONS="${MEXTENSIONS},-gnomevfs"
	fi

	if ! use composer ; then
		if ! use chatzilla && ! use mailclient ; then
			mozconfig_annotate '-composer' --disable-composer
		fi
	fi

	mozconfig_annotate '' --enable-crypto
	mozconfig_annotate '' --enable-extensions="${MEXTENSIONS}"
	mozconfig_annotate '' --enable-application=suite
	mozconfig_annotate 'broken' --disable-mochitest
	mozconfig_annotate 'broken' --disable-crashreporter
	mozconfig_annotate '' --enable-system-hunspell
	mozconfig_annotate '' --enable-jsd
	mozconfig_annotate '' --enable-image-encoder=all
	mozconfig_annotate '' --enable-canvas
	mozconfig_annotate '' --with-system-nspr
	mozconfig_annotate '' --with-system-nss
	mozconfig_annotate '' --with-system-bz2
	mozconfig_annotate '' --enable-oji --enable-mathml
	mozconfig_annotate 'places' --enable-storage --enable-places --enable-places_bookmarks
	mozconfig_annotate '' --disable-installer
	mozconfig_annotate '' --with-default-mozilla-five-home=${MOZILLA_FIVE_HOME}
	mozconfig_annotate '' --enable-printing

	# Enable/Disable based on USE flags
	mozconfig_use_enable alsa ogg
	mozconfig_use_enable alsa wave
	mozconfig_use_enable gnome gnomevfs
	mozconfig_use_enable gnome gnomeui
	mozconfig_use_enable java javaxpcom
	mozconfig_use_enable ldap
	mozconfig_use_enable ldap ldap-experimental
	mozconfig_use_enable mailclient mailnews
	mozconfig_use_enable system-sqlite

	# Finalize and report settings
	mozconfig_final

	if [[ $(gcc-major-version) -lt 4 ]]; then
		append-cxxflags -fno-stack-protector
	fi

	####################################
	#
	#  Configure and build
	#
	####################################

	# Work around breakage in makeopts with --no-print-directory
	MAKEOPTS="${MAKEOPTS/--no-print-directory/}"

	CC="$(tc-getCC)" CXX="$(tc-getCXX)" LD="$(tc-getLD)" econf
}

src_compile() {
	# Should the build use multiprocessing? Not enabled by default, as it tends to break.
	[ "${WANT_MP}" = "true" ] && jobs=${MAKEOPTS} || jobs="-j1"
	emake ${jobs} || die

	# Only build enigmail extension if conditions are met.
	if use crypt && use mailclient ; then
		emake -C "${S}"/mailnews/extensions/enigmail || die "make enigmail failed"
		emake -j1 -C "${S}"/mailnews/extensions/enigmail xpi || die "make enigmail xpi failed"
	fi
}

src_install() {
	declare MOZILLA_FIVE_HOME="/usr/$(get_libdir)/${PN}"
	declare emid

	emake DESTDIR="${D}" install || die "emake install failed"
	cp -f "${FILESDIR}"/icon/seamonkey.desktop "${T}" || die

	if use crypt && use mailclient ; then
		cd "${T}" || die
		unzip "${S}"/mozilla/dist/bin/enigmail*.xpi install.rdf || die
		emid=$(sed -n '/<em:id>/!d; s/.*\({.*}\).*/\1/; p; q' install.rdf)

		dodir ${MOZILLA_FIVE_HOME}/extensions/${emid} || die
		cd "${D}"${MOZILLA_FIVE_HOME}/extensions/${emid} || die
		unzip "${S}"/mozilla/dist/bin/enigmail*.xpi || die
	fi

	if use mailclient ; then
		sed 's|^\(MimeType=.*\)$|\1text/x-vcard;text/directory;application/mbox;message/rfc822;x-scheme-handler/mailto;|' \
			-i "${T}"/${PN}.desktop || die
		sed 's|^\(Categories=.*\)$|\1Email;|' -i "${T}"/${PN}.desktop \
			|| die
	fi

	if ${HAS_LANGS} ; then
		linguas
		for X in ${linguas}; do
			[[ ${X} != "en" ]] && xpi_install "${WORKDIR}"/"${MY_P}-${X}"
		done
	fi

	# Add StartupNotify=true bug 290401
	if use startup-notification ; then
		echo "StartupNotify=true" >> "${T}"/${PN}.desktop
	fi

	# Install icon and .desktop for menu entry
	newicon "${S}"/suite/branding/content/icon64.png seamonkey.png || die
	domenu "${T}"/${PN}.desktop || die

	# Add our default prefs
	sed "s|SEAMONKEY_PVR|${PVR}|" "${FILESDIR}"/all-gentoo.js \
		> "${D}"${MOZILLA_FIVE_HOME}/defaults/pref/all-gentoo.js

	# Plugins dir
	rm -rf "${D}"${MOZILLA_FIVE_HOME}/plugins || die "failed to remove existing plugins dir"
	dosym ../nsbrowser/plugins "${MOZILLA_FIVE_HOME}"/plugins || die

	# shiny new man page
	doman "${S}"/suite/app/${PN}.1 || die
}

pkg_preinst() {
	declare MOZILLA_FIVE_HOME="${ROOT}/usr/$(get_libdir)/${PN}"

	if [ -d ${MOZILLA_FIVE_HOME}/plugins ] ; then
		rm ${MOZILLA_FIVE_HOME}/plugins -rf
	fi
}

pkg_postinst() {
	declare MOZILLA_FIVE_HOME="/usr/$(get_libdir)/${PN}"

	# Update mimedb for the new .desktop file
	fdo-mime_desktop_database_update

	if use chatzilla ; then
		elog "chatzilla is now an extension which can be en-/disabled and configured via"
		elog "the Add-on manager."
	fi
}
