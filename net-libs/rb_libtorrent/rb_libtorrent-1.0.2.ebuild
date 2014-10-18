# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/rb_libtorrent/rb_libtorrent-1.0.2.ebuild,v 1.1 2014/10/18 19:35:55 hwoarang Exp $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3,3_4} )
PYTHON_REQ_USE="threads"

inherit multilib python-r1

MY_P=${P/rb_/}
MY_P=${MY_P/torrent/torrent-rasterbar}
S=${WORKDIR}/${MY_P}

DESCRIPTION="C++ BitTorrent implementation focusing on efficiency and scalability"
HOMEPAGE="http://www.rasterbar.com/products/libtorrent/"
SRC_URI="mirror://sourceforge/libtorrent/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="debug doc examples python ssl static-libs test"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

DEPEND=">=dev-libs/boost-1.53[threads]
	>=sys-devel/libtool-2.2
	sys-libs/zlib
	examples? ( !net-p2p/mldonkey )
	python? (
		${PYTHON_DEPS}
		dev-libs/boost[python,${PYTHON_USEDEP}]
	)
	ssl? ( dev-libs/openssl )"
RDEPEND="${DEPEND}"

src_prepare() {
	use python && python_copy_sources
}

src_configure() {
	local myconf=(
		--disable-silent-rules # bug 441842
		$(use_enable debug)
		$(use_enable test tests)
		$(use_enable examples)
		$(use_enable ssl encryption)
		$(use_enable static-libs static)
		--with-boost-libdir=/usr/$(get_libdir)
	)

	use debug && myconf+=( --enable-logging=verbose )

	econf "${myconf[@]}" --disable-python-binding
	if use python; then
		python_configure() {
			run_in_build_dir econf "${myconf[@]}" --enable-python-binding --with-boost-python=boost_python-${EPYTHON#python}
		}

		python_foreach_impl python_configure
	fi
}

src_install() {
	emake DESTDIR="${D}" install

	if use python; then
		python_install() {
			emake -C "${BUILD_DIR}"/bindings/python \
				DESTDIR="${D}" install
		}

		python_foreach_impl python_install
	fi

	use static-libs || find "${D}" -name '*.la' -exec rm -f {} +
	dodoc ChangeLog AUTHORS NEWS README
	if use doc; then
		dohtml docs/*
	fi
}
