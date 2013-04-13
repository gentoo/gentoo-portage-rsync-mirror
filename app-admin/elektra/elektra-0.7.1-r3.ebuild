# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/elektra/elektra-0.7.1-r3.ebuild,v 1.3 2013/04/13 02:08:44 xmw Exp $

EAPI=4

inherit autotools eutils multilib

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
		"${FILESDIR}"/${P}-automake-1.12.patch \
		"${FILESDIR}"/${P}-remove-ddefault-link.patch

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

src_compile() {
	dodir /usr/share/man/man3
	emake
}

src_install() {
	emake DESTDIR="${D}" install

	local my_f=""
	#avoid collision with kerberos (bug 403025, 447246)
	mkdir "${D}"/usr/include/elektra || die
	for my_f in kdb kdbbackend.h kdbos.h kdbtools.h keyset kdb.h \
		kdbloader.h kdbprivate.h key ; do
		mv "${D}"/usr/include/{,elektra\/}"${my_f}" || die
		elog "/usr/include/${my_f} installed as elektra/${my_f}"
	done
	sed -e '/^includedir/s/$/\/elektra/' \
		-i "${D}"/usr/$(get_libdir)/pkgconfig/elektra*.pc || die
	sed -e '/^Cflags/s/$/\/elektra/' \
		-i "${D}"/usr/$(get_libdir)/pkgconfig/elektra*.pc || die

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
