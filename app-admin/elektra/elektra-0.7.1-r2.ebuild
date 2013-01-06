# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/elektra/elektra-0.7.1-r2.ebuild,v 1.3 2012/11/06 19:26:18 mr_bones_ Exp $

EAPI=4

inherit autotools eutils

DESCRIPTION="universal and secure framework to store config parameters in a hierarchical key-value pair mechanism"
HOMEPAGE="http://freedesktop.org/wiki/Software/Elektra"
SRC_URI="ftp://ftp.markus-raab.org/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gcov iconv static-libs test"

RDEPEND="dev-libs/libxml2"
DEPEND="${RDEPEND}
	sys-devel/libtool
	iconv? ( virtual/libiconv )
	test? ( dev-libs/libxml2[static-libs] )"

src_prepare() {
	einfo 'Removing bundled libltdl'
	rm -rf libltdl || die

	epatch \
		"${FILESDIR}"/${P}-test.patch \
		"${FILESDIR}"/${P}-ltdl.patch \
		"${FILESDIR}"/${P}-automake-1.12.patch

	touch config.rpath
	eautoreconf
}

src_configure() {
	# berkeleydb, daemon, fstab, gconf, python do not work
	econf \
		--enable-filesys \
		--enable-hosts \
		--enable-ini \
		--enable-passwd \
		--disable-berkeleydb \
		--disable-fstab \
		--disable-gconf \
		--disable-daemon \
		--enable-cpp \
		--disable-python \
		$(use_enable gcov) \
		$(use_enable iconv) \
		$(use_enable static-libs static) \
		--with-docdir=/usr/share/doc/${PF} \
		--with-develdocdir=/usr/share/doc/${PF}
}

src_install() {
	emake DESTDIR="${D}" install

	local my_f=""
	#avoid collision with kerberos (bug 403025)
	for my_f in kdb kdbbackend.h kdbos.h kdbtools.h keyset kdb.h \
		kdbloader.h kdbprivate.h key ; do
		mv "${D}"/usr/include/{,elektra-}"${my_f}" || die
		elog "/usr/include/${my_f} installed as elektra-${my_f}"
	done
	sed -e '/^#include/s:kdbos.h:elektra-kdbos.h:' \
		-i "${D}"/usr/include/elektra-kdb.h || die

	#avoid collision with allegro (bug 409305)
	for my_f in $(find "${D}"/usr/share/man/man3 -name "key.3*") ; do
		mv "${my_f}" "${my_f/key/elektra-key}" || die
		elog "/usr/share/man/man3/$(basename "${my_f}") installed as $(basename "${my_f/key/elektra-key}")"
	done

	if ! use static-libs; then
		find "${D}" -name "*.a" -delete || die
	fi

	dodoc AUTHORS ChangeLog NEWS README TODO
}
