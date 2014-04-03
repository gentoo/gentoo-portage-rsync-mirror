# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/owfs/owfs-2.7_p21-r2.ebuild,v 1.1 2014/04/03 18:54:30 tomwij Exp $

EAPI="5"

PYTHON_DEPEND="python? 2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython 2.7-pypy-*"

inherit depend.php distutils eutils perl-module autotools user

MY_P=${P/_/}

DESCRIPTION="Access 1-Wire devices like a filesystem"
SRC_URI="mirror://sourceforge/owfs/${MY_P}.tar.gz"
HOMEPAGE="http://www.owfs.org/ http://owfs.sourceforge.net/"

KEYWORDS="~amd64 ~arm ~x86"
SLOT="0"
LICENSE="GPL-2"

RDEPEND="fuse? ( sys-fs/fuse )
	perl? ( dev-lang/perl )
	php? ( dev-lang/php )
	tcl? ( dev-lang/tcl )
	usb? ( virtual/libusb:0 )
	zeroconf? ( net-dns/avahi[mdnsresponder-compat] )"

DEPEND="${RDEPEND}
	perl? ( dev-lang/swig )
	php? ( dev-lang/swig )
	python? ( dev-lang/swig )"

IUSE="debug fuse ftpd httpd parport perl php python server tcl usb zeroconf"

S=${WORKDIR}/${MY_P}

OWUID=${OWUID:-owfs}
OWGID=${OWGID:-owfs}

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")
PYTHON_MODNAME="ow ownet"

pkg_setup() {
	if use php; then
		require_php_cli
	fi

	if use python; then
		python_pkg_setup
	fi

	enewgroup ${OWGID} 150
	enewuser  ${OWUID} 150 -1 -1 ${OWGID}
}

src_prepare() {
	sed -e 's/ \$(OWNET_SUBDIRPYTHON)//' -i module/ownet/Makefile.{am,in} || die
	sed -e 's/ \$(SWIG_SUBDIRPYTHON)//' -i module/swig/Makefile.{am,in} || die
	sed \
		-e "s/@PYCFLAGS@//" \
		-e "s/@PYLDFLAGS@//" \
		-i module/swig/python/setup.py.in || die "sed failed"

	# Support user's CFLAGS and LDFLAGS.
	sed -i "s/@CPPFLAGS@/@CPPFLAGS@ ${CFLAGS}/" \
		module/swig/perl5/OW/Makefile.linux.in || die
	sed -i "s/@LIBS@/@LIBS@ ${LDFLAGS}/" \
		module/swig/perl5/OW/Makefile.linux.in || die

	epatch "${FILESDIR}/${PN}-vendordir.patch"

	eautoreconf
}

src_configure() {
	econf \
		$(use_enable debug) \
		$(use_enable fuse owfs) \
		$(use_enable ftpd owftpd) \
		$(use_enable httpd owhttpd) \
		$(use_enable parport) \
		$(use_enable perl owperl) \
		$(use_enable php owphp) \
		$(use_enable python owpython) \
		$(use_enable server owserver) \
		$(use_enable tcl owtcl) \
		$(use_enable zeroconf zero) \
		$(use_enable usb)
}

src_compile() {
	default

	if use python; then
		pushd module/ownet/python > /dev/null
		distutils_src_compile
		popd > /dev/null

		pushd module/swig/python > /dev/null
		emake ow_wrap.c
		distutils_src_compile
		popd > /dev/null
	fi
}

src_test() { :; }

src_install() {
	default

	if use server || use httpd || use ftpd || use fuse; then
		diropts -m 0750 -o ${OWUID} -g ${OWGID}
		dodir /var/run/owfs

		for i in server httpd ftpd; do
			if use ${i}; then
				newinitd "${FILESDIR}"/ow${i}.initd ow${i}
				newconfd "${FILESDIR}"/ow${i}.confd ow${i}
			fi
		done

		if use fuse; then
			dodir /var/lib/owfs
			dodir /var/lib/owfs/mnt
			newinitd "${FILESDIR}"/owfs.initd owfs
			newconfd "${FILESDIR}"/owfs.confd owfs
		fi
	fi
	use perl && fixlocalpod

	if use python; then
		pushd module/ownet/python > /dev/null
		distutils_src_install
		popd > /dev/null

		pushd module/swig/python > /dev/null
		distutils_src_install
		popd > /dev/null
	fi
}

pkg_postinst() {
	if use server || use httpd || use ftpd || use fuse; then
		echo
		einfo
		einfo "Be sure to check/edit the following files,"
		einfo "e.g. to fit your 1 wire bus controller"
		einfo "device or daemon network settings:"
		for i in server httpd ftpd; do
			if use ${i}; then
				einfo "- ${ROOT%/}/etc/conf.d/ow${i}"
			fi
		done
		if use fuse; then
			einfo "- ${ROOT%/}/etc/conf.d/owfs"
		fi
		einfo
		echo
		if [[ ${OWUID} != root ]]; then
			ewarn
			ewarn "In order to allow the OWFS daemon user '${OWUID}' to read"
			ewarn "from and/or write to a 1 wire bus controller device, make"
			ewarn "sure the user has appropriate permission to access the"
			ewarn "corresponding device node/path (e.g. /dev/ttyS0), for example"
			ewarn "by adding the user to the group 'uucp' (for serial devices)"
			ewarn "or 'usb' (for USB devices accessed via usbfs on /proc/bus/usb)."
			ewarn
			if use fuse; then
				ewarn "In order to allow regular users to read from and/or write to"
				ewarn "1 wire bus devices accessible via the owfs FUSE filesystem"
				ewarn "client and its filesystem mountpoint, make sure the user is"
				ewarn "a member of the group '${OWGID}'."
				ewarn
			fi
			echo
		fi
	fi

	use python && distutils_pkg_postinst
}

pkg_postrm() {
	use python && distutils_pkg_postrm
}
