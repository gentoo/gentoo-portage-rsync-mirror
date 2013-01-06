# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hwloc/hwloc-1.4.2.ebuild,v 1.2 2012/05/30 12:33:17 aballier Exp $

EAPI=4

inherit multilib versionator

MY_PV=v$(get_version_component_range 1-2)

DESCRIPTION="displays the hardware topology in convenient formats"
HOMEPAGE="http://www.open-mpi.org/projects/hwloc/"
SRC_URI="http://www.open-mpi.org/software/${PN}/${MY_PV}/downloads/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux"
IUSE="cairo debug +numa +pci svg static-libs xml X"

RDEPEND="sys-libs/ncurses
	cairo? ( x11-libs/cairo[X?,svg?] )
	pci? ( sys-apps/pciutils )
	xml? ( dev-libs/libxml2 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	numa? ( sys-process/numactl )"

DOCS=( AUTHORS NEWS README VERSION )

src_configure() {
	export HWLOC_PKG_CONFIG=$(tc-getPKG_CONFIG) #393467
	econf \
		--docdir="${EPREFIX}"/usr/share/doc/${PF} \
		$(use_enable cairo) \
		$(use_enable debug) \
		$(use_enable pci) \
		$(use_enable numa libnuma) \
		$(use_enable static-libs static) \
		$(use_enable xml libxml2) \
		$(use_with X x) \
		--disable-silent-rules
}

src_install() {
	default
	use static-libs || rm "${D}"/usr/$(get_libdir)/lib${PN}.la
}
