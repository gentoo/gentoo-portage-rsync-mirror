# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/webkit-gtk/webkit-gtk-1.8.3-r200.ebuild,v 1.12 2013/06/18 06:10:56 tetromino Exp $

EAPI="4"

PYTHON_COMPAT=( python{2_5,2_6,2_7} )

inherit autotools check-reqs eutils flag-o-matic gnome2-utils pax-utils python-any-r1 virtualx

MY_P="webkit-${PV}"
DESCRIPTION="Open source web browser engine"
HOMEPAGE="http://www.webkitgtk.org/"
SRC_URI="http://www.webkitgtk.org/releases/${MY_P}.tar.xz"

LICENSE="LGPL-2+ BSD"
SLOT="2"
KEYWORDS="alpha amd64 arm ia64 ppc ppc64 sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux ~x86-macos"
IUSE="aqua coverage debug +geoloc +gstreamer +introspection +jit spell +webgl"
# bugs 372493, 416331
REQUIRED_USE="introspection? ( geoloc gstreamer )"

# use sqlite, svg by default
# dependency on >=x11-libs/gtk+-2.13:2 for gail
RDEPEND="
	dev-libs/libxml2:2
	dev-libs/libxslt
	virtual/jpeg
	>=media-libs/libpng-1.4:0
	>=x11-libs/cairo-1.10
	>=dev-libs/glib-2.32:2
	>=x11-libs/gtk+-2.13:2[aqua=,introspection?]
	>=dev-libs/icu-3.8.1-r1
	>=net-libs/libsoup-2.37.92:2.4[introspection?]
	dev-db/sqlite:3
	>=x11-libs/pango-1.21
	x11-libs/libXrender

	geoloc? ( app-misc/geoclue )

	gstreamer? (
		media-libs/gstreamer:0.10
		>=media-libs/gst-plugins-base-0.10.30:0.10 )

	introspection? ( >=dev-libs/gobject-introspection-0.9.5 )

	spell? ( >=app-text/enchant-0.22 )

	webgl? ( virtual/opengl )
"
# paxctl needed for bug #407085
DEPEND="${RDEPEND}
	${PYTHON_DEPS}
	dev-lang/perl
	sys-devel/bison
	>=sys-devel/flex-2.5.33
	sys-devel/gettext
	dev-util/gperf
	virtual/pkgconfig
	dev-util/gtk-doc-am
	introspection? ( jit? ( sys-apps/paxctl ) )
	test? (
		dev-lang/python:2.7
		dev-python/pygobject:3[python_targets_python2_7]
		x11-themes/hicolor-icon-theme
		jit? ( sys-apps/paxctl ) )
"
# Need real bison, not yacc

S="${WORKDIR}/${MY_P}"

CHECKREQS_DISK_BUILD="18G" # and even this might not be enough, bug #417307

pkg_pretend() {
	if [[ ${MERGE_TYPE} != "binary" ]] && is-flagq "-g*" && ! is-flagq "-g*0" ; then
		einfo "Checking for sufficient disk space to build ${PN} with debugging CFLAGS"
		check-reqs_pkg_pretend
	fi
}

pkg_setup() {
	# Check whether any of the debugging flags is enabled
	if [[ ${MERGE_TYPE} != "binary" ]] && is-flagq "-g*" && ! is-flagq "-g*0" ; then
		if is-flagq "-ggdb" && [[ ${WEBKIT_GTK_GGDB} != "yes" ]]; then
			replace-flags -ggdb -g
			ewarn "Replacing \"-ggdb\" with \"-g\" in your CFLAGS."
			ewarn "Building ${PN} with \"-ggdb\" produces binaries which are too"
			ewarn "large for current binutils releases (bug #432784) and has very"
			ewarn "high temporary build space and memory requirements."
			ewarn "If you really want to build ${PN} with \"-ggdb\", add"
			ewarn "WEBKIT_GTK_GGDB=yes"
			ewarn "to your make.conf file."
		fi
		einfo "You need to have at least 18GB of temporary build space available"
		einfo "to build ${PN} with debugging CFLAGS. Note that it might still"
		einfo "not be enough, as the total space requirements depend on the flags"
		einfo "(-ggdb vs -g1) and enabled features."
		check-reqs_pkg_setup
	fi

	[[ ${MERGE_TYPE} = "binary" ]] || python-any-r1_pkg_setup
}

src_prepare() {
	DOCS="ChangeLog NEWS" # other ChangeLog files handled by src_install

	# FIXME: Fix unaligned accesses on ARM, IA64 and SPARC
	# https://bugs.webkit.org/show_bug.cgi?id=19775
	# TODO: FAILS TO APPLY!
	#use sparc && epatch "${FILESDIR}"/${PN}-1.2.3-fix-pool-sparc.patch

	# USE=-gstreamer build failure, bug #412221, https://bugs.webkit.org/show_bug.cgi?id=84526
	epatch "${FILESDIR}/${PN}-1.8.1-CodeGeneratorGObject-properties.patch"

	# bug #416057; in 1.9.x
	epatch "${FILESDIR}/${PN}-1.8.1-gst-required-version.patch"

	# bug #428012; in 1.9.x
	epatch "${FILESDIR}/${PN}-1.8.2-bison-2.6.patch"

	# bug #417523, https://bugs.webkit.org/show_bug.cgi?id=96602
	epatch "${FILESDIR}/${PN}-1.8.3-libdl.patch"

	# uclibc fix, bug #441674
	epatch "${FILESDIR}/${PN}-1.8.3-disable-backtrace-uclibc.patch"

	# intermediate MacPorts hack while upstream bug is not fixed properly
	# https://bugs.webkit.org/show_bug.cgi?id=28727
	use aqua && epatch "${FILESDIR}"/${PN}-1.6.1-darwin-quartz.patch

	# Bug #403049, https://bugs.webkit.org/show_bug.cgi?id=79605
	epatch "${FILESDIR}/${PN}-1.7.5-linguas.patch"

	# Drop DEPRECATED flags
	sed -i -e 's:-D[A-Z_]*DISABLE_DEPRECATED:$(NULL):g' GNUmakefile.am || die

	# Don't force -O2
	sed -i 's/-O2//g' "${S}"/configure.ac || die

	# Build-time segfaults under PaX with USE="introspection jit", bug #404215
	if use introspection && use jit; then
		epatch "${FILESDIR}/${PN}-1.6.3-paxctl-introspection.patch"
		cp "${FILESDIR}/gir-paxctl-lt-wrapper" "${S}/" || die
	fi

	# We need to reset some variables to prevent permissions problems and failures
	# like https://bugs.webkit.org/show_bug.cgi?id=35471 and bug #323669
	gnome2_environment_reset

	# https://bugs.webkit.org/show_bug.cgi?id=79498
	epatch "${FILESDIR}/${PN}-1.7.90-parallel-make-hack.patch"

	# XXX: failing tests
	# https://bugs.webkit.org/show_bug.cgi?id=50744
	# testkeyevents is interactive
	# mimehandling test sometimes fails under Xvfb (works fine manually)
	# datasource test needs a network connection and intermittently fails with icedtea-web
	# webplugindatabase intermittently fails with icedtea-web
	sed -e '/Programs\/unittests\/testwebinspector/ d' \
		-e '/Programs\/unittests\/testkeyevents/ d' \
		-e '/Programs\/unittests\/testmimehandling/ d' \
		-e '/Programs\/unittests\/testwebdatasource/ d' \
		-e '/Programs\/unittests\/testwebplugindatabase/ d' \
		-i Source/WebKit/gtk/GNUmakefile.am || die
	# garbage collection test fails intermittently if icedtea-web is installed
	epatch "${FILESDIR}/${PN}-1.7.90-test_garbage_collection.patch"

	# occasional test failure due to additional Xvfb process spawned
	epatch "${FILESDIR}/${PN}-1.8.1-tests-xvfb.patch"

	# For >=sys-devel/automake-1.12 compability wrt #420591
	sed -i -e 's:mkdir_p:MKDIR_P:' {.,Source/WebKit/gtk/po}/GNUmakefile.am || die

	# Respect CC, otherwise fails on prefix #395875
	tc-export CC

	# Prevent maintainer mode from being triggered during make
	AT_M4DIR=Source/autotools eautoreconf

	# Ugly hack of a workaround for bizarre paludis behavior, bug #406117
	# http://paludis.exherbo.org/trac/ticket/1230
	sed -e '/  --\(en\|dis\)able-dependency-tracking/ d' -i configure || die
}

src_configure() {
	# It doesn't compile on alpha without this in LDFLAGS
	use alpha && append-ldflags "-Wl,--no-relax"

	# Sigbuses on SPARC with mcpu and co.
	use sparc && filter-flags "-mvis"

	# https://bugs.webkit.org/show_bug.cgi?id=42070 , #301634
	use ppc64 && append-flags "-mminimal-toc"

	local myconf

	# XXX: Check Web Audio support
	# XXX: dependency-tracking is required so parallel builds won't fail
	# WebKit2 can only be built with gtk3
	# API documentation (gtk-doc) is built in webkit-gtk:3, always disable here
	myconf="
		$(use_enable coverage)
		$(use_enable debug)
		$(use_enable debug debug-features)
		$(use_enable geoloc geolocation)
		$(use_enable spell spellcheck)
		$(use_enable introspection)
		$(use_enable gstreamer video)
		$(use_enable jit)
		$(use_enable webgl)
		--enable-web-sockets
		--with-gtk=2.0
		--disable-gtk-doc
		--disable-webkit2
		--enable-dependency-tracking
		$(use aqua && echo "--with-font-backend=pango --with-target=quartz")"

	econf ${myconf}
}

src_compile() {
	# Horrible failure of a hack to work around parallel make problems,
	# see https://bugs.webkit.org/show_bug.cgi?id=79498
	emake -j1 all-built-sources-local
	emake all-ltlibraries-local
	emake all-programs-local
	use introspection && emake WebKit-1.0.gir
	emake all-data-local
	default
}

src_test() {
	# Tests expect an out-of-source build in WebKitBuild
	ln -s . WebKitBuild || die "ln failed"
	# Prevents test failures on PaX systems
	use jit && pax-mark m $(list-paxables Programs/unittests/test*) \
		Programs/unittests/.libs/test*
	unset DISPLAY
	# Tests need virtualx, bug #294691, bug #310695
	# Parallel tests sometimes fail
	Xemake -j1 check
}

src_install() {
	default

	newdoc Source/WebKit/gtk/ChangeLog ChangeLog.gtk
	newdoc Source/WebKit/gtk/po/ChangeLog ChangeLog.gtk-po
	newdoc Source/JavaScriptCore/ChangeLog ChangeLog.JavaScriptCore
	newdoc Source/WebCore/ChangeLog ChangeLog.WebCore

	# Remove .la files
	find "${D}" -name '*.la' -exec rm -f '{}' +

	# Prevents crashes on PaX systems
	use jit && pax-mark m "${ED}usr/bin/jsc-1"

	# File collisions with slot 3
	# bug #402699, https://bugs.webkit.org/show_bug.cgi?id=78134
	rm -rf "${ED}usr/share/gtk-doc" || die
}
