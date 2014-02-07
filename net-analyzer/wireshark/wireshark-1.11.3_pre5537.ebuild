# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/wireshark/wireshark-1.11.3_pre5537.ebuild,v 1.2 2014/02/07 18:17:03 jer Exp $

EAPI=5
inherit autotools eutils fcaps qt4-r2 user

[[ -n ${PV#*_rc} && ${PV#*_rc} != ${PV} ]] && MY_P=${PN}-${PV/_} || MY_P=${P}
DESCRIPTION="A network protocol analyzer formerly known as ethereal"
HOMEPAGE="http://www.wireshark.org/"
SRC_URI="http://www.wireshark.org/download/automated/src/${P/_pre*}-SVN-${PV/*_pre}.tar.bz2"

LICENSE="GPL-2"
SLOT="0/${PV}"
KEYWORDS=""
IUSE="
	adns +caps crypt doc doc-pdf geoip gtk2 +gtk3 ipv6 kerberos libadns lua
	+netlink +pcap portaudio +qt4 selinux smi ssl zlib
"
REQUIRED_USE="
	?? ( gtk2 gtk3 )
	ssl? ( crypt )
"

GTK_COMMON_DEPEND="
	x11-libs/gdk-pixbuf
	x11-libs/pango
	x11-misc/xdg-utils
"
RDEPEND="
	>=dev-libs/glib-2.14:2
	netlink? ( dev-libs/libnl )
	adns? ( !libadns? ( >=net-dns/c-ares-1.5 ) )
	crypt? ( dev-libs/libgcrypt:0 )
	caps? ( sys-libs/libcap )
	geoip? ( dev-libs/geoip )
	gtk2? (
		${GTK_COMMON_DEPEND}
		>=x11-libs/gtk+-2.4.0:2
	)
	gtk3? (
		${GTK_COMMON_DEPEND}
		x11-libs/gtk+:3
	)
	kerberos? ( virtual/krb5 )
	libadns? ( net-libs/adns )
	lua? ( >=dev-lang/lua-5.1 )
	pcap? ( net-libs/libpcap[-netlink] )
	portaudio? ( media-libs/portaudio )
	qt4? (
		dev-qt/qtcore:4
		dev-qt/qtgui:4
		x11-misc/xdg-utils
		)
	selinux? ( sec-policy/selinux-wireshark )
	smi? ( net-libs/libsmi )
	ssl? ( net-libs/gnutls )
	zlib? ( sys-libs/zlib !=sys-libs/zlib-1.2.4 )
"

DEPEND="
	${RDEPEND}
	doc? (
		app-doc/doxygen
		app-text/asciidoc
		dev-libs/libxml2
		dev-libs/libxslt
		doc-pdf? ( dev-java/fop )
		www-client/lynx
	)
	>=virtual/perl-Pod-Simple-3.170.0
	sys-devel/bison
	sys-devel/flex
	virtual/perl-Getopt-Long
	virtual/perl-Time-Local
	virtual/pkgconfig
"

S=${WORKDIR}/${P/_pre*}-SVN-${PV/*_pre}

pkg_setup() {
	enewgroup wireshark
}

src_prepare() {
	epatch \
		"${FILESDIR}"/${PN}-1.6.13-ldflags.patch \
		"${FILESDIR}"/${PN}-1.11.0-oldlibs.patch \
		"${FILESDIR}"/${PN}-1.11.3-gtk-deprecated-warnings.patch

	# Qt5 support is broken since the build system does not determine
	# which `moc' it ought to use
	sed -i -e 's|Qt5||g' acinclude.m4 || die

	epatch_user

	eautoreconf
}

src_configure() {
	local myconf

	if use adns; then
		if use libadns; then
			myconf+=( "--with-adns --without-c-ares" )
		else
			myconf+=( "--without-adns --with-c-ares" )
		fi
	else
		if use libadns; then
			myconf+=( "--with-adns --without-c-ares" )
		else
			myconf+=( "--without-adns --without-c-ares" )
		fi
	fi

	# Workaround bug #213705. If krb5-config --libs has -lcrypto then pass
	# --with-ssl to ./configure. (Mimics code from acinclude.m4).
	if use kerberos; then
		case $(krb5-config --libs) in
			*-lcrypto*)
				ewarn "Kerberos was built with ssl support: linkage with openssl is enabled."
				ewarn "Note there are annoying license incompatibilities between the OpenSSL"
				ewarn "license and the GPL, so do your check before distributing such package."
				myconf+=( "--with-ssl" )
				;;
		esac
	fi

	# Enable wireshark binary with any supported GUI toolkit (bug #473188)
	if use gtk2 || use gtk3 || use qt4 ; then
		myconf+=( "--enable-wireshark" )
	else
		myconf+=( "--disable-wireshark" )
	fi

	# Hack around inability to disable doxygen/fop doc generation
	use doc || export ac_cv_prog_HAVE_DOXYGEN=false
	use doc-pdf || export ac_cv_prog_HAVE_FOP=false

	# dumpcap requires libcap
	# --disable-profile-build bugs #215806, #292991, #479602
	econf \
		$(use_enable ipv6) \
		$(use_with caps libcap) \
		$(use_with crypt gcrypt) \
		$(use_with geoip) \
		$(use_with gtk2) \
		$(use_with gtk3) \
		$(use_with kerberos krb5) \
		$(use_with lua) \
		$(use_with netlink libnl) \
		$(use_with pcap dumpcap-group wireshark) \
		$(use_with pcap) \
		$(use_with portaudio) \
		$(use_with qt4 qt) \
		$(use_with smi libsmi) \
		$(use_with ssl gnutls) \
		$(use_with zlib) \
		--disable-extra-gcc-checks \
		--disable-profile-build \
		--disable-usr-local \
		--sysconfdir="${EPREFIX}"/etc/wireshark \
		${myconf[@]}
}

src_compile() {
	default
	use doc && emake -j1 -C docbook
}

src_install() {
	default
	if use doc; then
		dohtml -r docbook/{release-notes.html,ws{d,u}g_html{,_chunked}}
		if use doc-pdf; then
			insinto /usr/share/doc/${PF}/pdf/
			doins docbook/{{developer,user}-guide,release-notes}-{a4,us}.pdf
		fi
	fi

	# FAQ is not required as is installed from help/faq.txt
	dodoc AUTHORS ChangeLog NEWS README{,.bsd,.linux,.macos,.vmware} \
		doc/{randpkt.txt,README*}

	# install headers
	local wsheader
	for wsheader in $( echo $(< debian/wireshark-dev.header-files ) ); do
		insinto /usr/include/wireshark/$( dirname ${wsheader} )
		doins ${wsheader}
	done

	#with the above this really shouldn't be needed, but things may be looking in wiretap/ instead of wireshark/wiretap/
	insinto /usr/include/wiretap
	doins wiretap/wtap.h

	if use gtk2 || use gtk3 || use qt4; then
		local c d
		for c in hi lo; do
			for d in 16 32 48; do
				insinto /usr/share/icons/${c}color/${d}x${d}/apps
				newins image/${c}${d}-app-wireshark.png wireshark.png
			done
		done
	fi

	if use gtk2 || use gtk3; then
		domenu wireshark.desktop
	fi

	if use qt4; then
		sed -e '/Exec=/s|wireshark|&-qt|g' wireshark.desktop > wireshark-qt.desktop || die
		domenu wireshark-qt.desktop
	fi

	prune_libtool_files
}

pkg_postinst() {
	# Add group for users allowed to sniff.
	enewgroup wireshark

	if use pcap; then
		fcaps -o 0 -g wireshark -m 4710 -M 0710 \
			cap_dac_read_search,cap_net_raw,cap_net_admin \
			"${EROOT}"/usr/bin/dumpcap
	fi

	ewarn "NOTE: To run wireshark as normal user you have to add yourself to"
	ewarn "the wireshark group. This security measure ensures that only trusted"
	ewarn "users are allowed to sniff your traffic."
}
