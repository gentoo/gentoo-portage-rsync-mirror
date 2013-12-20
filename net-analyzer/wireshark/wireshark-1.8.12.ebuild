# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/wireshark/wireshark-1.8.12.ebuild,v 1.4 2013/12/20 15:22:27 jer Exp $

EAPI=5
PYTHON_COMPAT=( python2_6 python2_7 )
inherit autotools eutils fcaps flag-o-matic python-single-r1 user

[[ -n ${PV#*_rc} && ${PV#*_rc} != ${PV} ]] && MY_P=${PN}-${PV/_} || MY_P=${P}
DESCRIPTION="A network protocol analyzer formerly known as ethereal"
HOMEPAGE="http://www.wireshark.org/"
SRC_URI="http://www.wireshark.org/download/src/all-versions/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0/${PV}"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~ppc ~ppc64 ~sparc x86 ~x86-fbsd"
IUSE="
	adns +caps crypt doc doc-pdf geoip gtk ipv6 kerberos libadns lua +pcap
	portaudio python selinux smi ssl zlib
"
REQUIRED_USE="
	ssl? ( crypt )
"
RDEPEND="
	>=dev-libs/glib-2.14:2
	adns? ( !libadns? ( >=net-dns/c-ares-1.5 ) )
	caps? ( sys-libs/libcap )
	crypt? ( dev-libs/libgcrypt:= )
	geoip? ( dev-libs/geoip )
	gtk? (
		>=x11-libs/gtk+-2.4.0:2
		dev-libs/atk
		x11-libs/pango
		x11-misc/xdg-utils
	)
	kerberos? ( virtual/krb5 )
	libadns? ( net-libs/adns )
	lua? ( <dev-lang/lua-5.2 )
	pcap? ( net-libs/libpcap )
	portaudio? ( media-libs/portaudio )
	python? ( ${PYTHON_DEPS} )
	selinux? ( sec-policy/selinux-wireshark )
	smi? ( net-libs/libsmi )
	ssl? ( net-libs/gnutls )
	zlib? ( sys-libs/zlib !=sys-libs/zlib-1.2.4 )
"

DEPEND="
	${RDEPEND}
	doc? (
		app-doc/doxygen
		dev-libs/libxml2
		dev-libs/libxslt
		doc-pdf? ( dev-java/fop )
	)
	>=virtual/perl-Pod-Simple-3.170.0
	sys-devel/bison
	sys-devel/flex
	virtual/perl-Getopt-Long
	virtual/perl-Time-Local
	virtual/pkgconfig
"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	if ! use gtk; then
		ewarn "USE=-gtk disables gtk-based gui called wireshark."
		ewarn "Only command line utils will be built available"
	fi

	if use python; then
		python-single-r1_pkg_setup
	fi

	# Add group for users allowed to sniff.
	enewgroup wireshark
}

src_prepare() {
	epatch \
		"${FILESDIR}"/${PN}-1.6.13-ldflags.patch \
		"${FILESDIR}"/${PN}-1.8.12-gtk-deprecated-warnings.patch

	sed -i -e '/^Icon/s|.png||g' ${PN}.desktop || die

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
		case `krb5-config --libs` in
			*-lcrypto*)
				ewarn "Kerberos was built with ssl support: linkage with openssl is enabled."
				ewarn "Note there are annoying license incompatibilities between the OpenSSL"
				ewarn "license and the GPL, so do your check before distributing such package."
				myconf+=( "--with-ssl" )
				;;
		esac
	fi

	# Hack around inability to disable doxygen/fop doc generation
	use doc || export ac_cv_prog_HAVE_DOXYGEN=false
	use doc-pdf || export ac_cv_prog_HAVE_FOP=false

	# dumpcap requires libcap, setuid-install requires dumpcap
	# --disable-profile-build bugs #215806, #292991, #479602
	econf \
		$(use pcap && use_enable !caps setuid-install) \
		$(use pcap && use_enable caps setcap-install) \
		$(use_enable gtk wireshark) \
		$(use_enable ipv6) \
		$(use_with crypt gcrypt) \
		$(use_with caps libcap) \
		$(use_with geoip) \
		$(use_with kerberos krb5) \
		$(use_with lua) \
		$(use_with pcap dumpcap-group wireshark) \
		$(use_with pcap) \
		$(use_with portaudio) \
		$(use_with python) \
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

	if use gtk; then
		for c in hi lo; do
			for d in 16 32 48; do
				insinto /usr/share/icons/${c}color/${d}x${d}/apps
				newins image/${c}${d}-app-wireshark.png wireshark.png
			done
		done
		domenu wireshark.desktop
	fi

	use pcap && chmod o-x "${ED}"/usr/bin/dumpcap #357237

	if use python; then
		python_optimize "${ED}"/usr/lib*/wireshark/python
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
