# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/spandsp/spandsp-0.0.6.ebuild,v 1.3 2015/01/29 17:59:02 mgorny Exp $

EAPI="5"

inherit multilib versionator

DESCRIPTION="SpanDSP is a library of DSP functions for telephony"
HOMEPAGE="http://www.soft-switch.org/"
SRC_URI="http://www.soft-switch.org/downloads/spandsp/${P/_}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86"
IUSE="doc fixed-point cpu_flags_x86_mmx cpu_flags_x86_sse cpu_flags_x86_sse2 cpu_flags_x86_sse3 cpu_flags_x86_ssse3 cpu_flags_x86_sse4a cpu_flags_x86_avx static-libs"

RDEPEND="media-libs/tiff
	 virtual/jpeg"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen
		dev-libs/libxslt )"

S=${WORKDIR}/${PN}-$(get_version_component_range 1-3)

# TODO:
# there are two tests options: tests and test-data
# 	they need audiofile, fftw, libxml and probably more
# configure script is auto-enabling some sse* options sometimes

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable doc) \
		$(use_enable fixed-point) \
		$(use_enable cpu_flags_x86_mmx mmx) \
		$(use_enable cpu_flags_x86_sse sse) \
		$(use_enable cpu_flags_x86_sse2 sse2) \
		$(use_enable cpu_flags_x86_sse3 sse3) \
		$(use_enable cpu_flags_x86_ssse3 ssse3) \
		$(use_enable cpu_flags_x86_sse4a sse4a) \
		$(use_enable cpu_flags_x86_avx avx) \
		$(use_enable static-libs static)
}

src_install () {
	emake DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog DueDiligence NEWS README

	if ! use static-libs; then
		# remove useless la file when not installing static lib
		rm "${D}"/usr/$(get_libdir)/lib${PN}.la || die "rm failed"
	fi

	if use doc; then
		dohtml -r doc/{api/html/*,t38_manual}
	fi
}
