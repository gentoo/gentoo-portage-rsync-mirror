# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/brltty/brltty-4.5-r3.ebuild,v 1.3 2014/01/07 17:56:07 nimiux Exp $

EAPI=5

FINDLIB_USE="ocaml"

inherit findlib eutils multilib toolchain-funcs java-pkg-opt-2 flag-o-matic \
	autotools udev

DESCRIPTION="Daemon that provides access to the Linux/Unix console for a blind person"
HOMEPAGE="http://mielke.cc/brltty/"
SRC_URI="http://mielke.cc/brltty/releases/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE="+api +beeper bluetooth +contracted-braille doc +fm gpm iconv icu
		java +learn-mode +midi ncurses nls ocaml +pcm python usb +speech
		tcl X"
REQUIRED_USE="doc? ( api )
	java? ( api )
	ocaml? ( api )
	python? ( api )
	tcl? ( api )"

COMMON_DEP="bluetooth? ( net-wireless/bluez )
	gpm? ( >=sys-libs/gpm-1.20 )
	iconv? ( virtual/libiconv )
	icu? ( dev-libs/icu:= )
	ncurses? ( sys-libs/ncurses )
	nls? ( virtual/libintl )
	python? ( >=dev-python/cython-0.16 )
	tcl? ( >=dev-lang/tcl-8.4.15 )
	usb? ( virtual/libusb:0 )
	X? ( x11-libs/libXaw )"
DEPEND="virtual/pkgconfig
	java? ( >=virtual/jdk-1.4 )
	${COMMON_DEP}"
RDEPEND="java? ( >=virtual/jre-1.4 )
	${COMMON_DEP}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-fix-ldflags.patch \
		"${FILESDIR}"/${P}-udev.patch \
		"${FILESDIR}"/${P}-fix-mk4build-cross.patch \
		"${FILESDIR}"/${P}-range-checking-and-array-bounds.patch \
		"${FILESDIR}"/${P}-respect-AR.patch

	java-pkg-opt-2_src_prepare

	# We run eautoconf instead of using eautoreconf because brltty uses
	# a custom build system that uses autoconf without the rest of the
	# autotools.
	eautoconf
}

src_configure() {
	tc-export AR LD
	# override prefix in order to install into /
	# braille terminal needs to be available as soon in the boot process as
	# possible
	# Also override localstatedir so that the lib/brltty directory is installed
	# correctly.
	# Disable stripping since we do that ourselves.
	econf \
		--prefix=/ \
		--includedir=/usr/include \
		--localstatedir=/var \
		--disable-stripping \
		--with-install-root="${D}" \
		$(use_enable api) \
		$(use_enable beeper beeper-support) \
		$(use_enable contracted-braille) \
		$(use_enable fm fm-support) \
		$(use_enable gpm) \
		$(use_enable iconv) \
		$(use_enable icu) \
		$(use_enable java java-bindings) \
		$(use_enable learn-mode) \
		$(use_enable midi midi-support) \
		$(use_enable nls i18n) \
		$(use_enable ocaml ocaml-bindings) \
		$(use_enable pcm pcm-support) \
		$(use_enable python python-bindings) \
		$(use_enable speech speech-support) \
		$(use_enable tcl tcl-bindings) \
		$(use_enable X x) \
		$(use_with bluetooth bluetooth-package) \
		$(use_with ncurses curses) \
		$(use_with usb usb-package)
}

src_compile() {
	local JAVAC_CONF=""
	local OUR_JNI_FLAGS=""
	if use java; then
		OUR_JNI_FLAGS="$(java-pkg_get-jni-cflags)"
		JAVAC_CONF="${JAVAC} -encoding UTF-8 $(java-pkg_javac-args)"
	fi

	emake JAVA_JNI_FLAGS="${OUR_JNI_FLAGS}" JAVAC="${JAVAC_CONF}"
}

src_install() {
	if use ocaml; then
		findlib_src_preinst
	fi

	emake OCAML_LDCONF= install

	if use java; then
		# make install puts the _java.so there, and no it's not $(get_libdir)
		rm -rf "${D}/usr/lib/java"
		java-pkg_doso Bindings/Java/libbrlapi_java.so
		java-pkg_dojar Bindings/Java/brlapi.jar
	fi

	insinto /etc
	doins Documents/brltty.conf
	udev_newrules Hotplug/udev.rules 70-brltty.rules
	newinitd "${FILESDIR}"/brltty.rc brltty

	libdir="$(get_libdir)"
	mkdir -p "${D}"/usr/${libdir}/
	mv "${D}"/${libdir}/*.a "${D}"/usr/${libdir}/
	gen_usr_ldscript libbrlapi.so

	cd Documents
	mv Manual-BRLTTY/English/BRLTTY.txt BRLTTY-en.txt
	mv Manual-BRLTTY/French/BRLTTY.txt BRLTTY-fr.txt
	mv Manual-BrlAPI/English/BrlAPI.txt BrlAPI-en.txt
	dodoc CONTRIBUTORS ChangeLog HISTORY README* TODO BRLTTY-*.txt
	dohtml -r Manual-BRLTTY
	if use doc; then
		dohtml -r Manual-BrlAPI
		dodoc BrlAPI-*.txt
	fi
}

pkg_postinst() {
	elog
	elog please be sure "${ROOT}"etc/brltty.conf is correct for your system.
	elog
	elog To make brltty start on boot, type this command as root:
	elog
	elog rc-update add brltty boot
}
