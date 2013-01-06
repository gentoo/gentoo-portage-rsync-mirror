# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/wget/wget-1.13.4.ebuild,v 1.2 2012/08/06 19:42:06 vapier Exp $

EAPI=4

inherit flag-o-matic

DESCRIPTION="Network utility to retrieve files from the WWW"
HOMEPAGE="http://www.gnu.org/software/wget/"
SRC_URI="mirror://gnu/wget/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~ppc-aix ~sparc-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~hppa-hpux ~ia64-hpux ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="debug gnutls idn ipv6 nls ntlm +ssl static"

RDEPEND="idn? ( net-dns/libidn )
	ssl? (
		gnutls? ( net-libs/gnutls )
		!gnutls? ( >=dev-libs/openssl-0.9.6b )
	)"
DEPEND="${RDEPEND}
	app-arch/xz-utils
	nls? ( sys-devel/gettext )"

REQUIRED_USE="ntlm? ( !gnutls ssl )
	gnutls? ( ssl )"

DOCS=( AUTHORS MAILING-LIST NEWS README doc/sample.wgetrc )

src_configure() {
	# openssl-0.9.8 now builds with -pthread on the BSD's
	use elibc_FreeBSD && use ssl && append-ldflags -pthread
	# fix compilation on Solaris, we need filio.h for FIONBIO as used in
	# the included gnutls -- force ioctl.h to include this header
	[[ ${CHOST} == *-solaris* ]] && append-flags -DBSD_COMP=1

	use static && append-ldflags -static
	econf \
		--disable-rpath \
		$(use_with ssl ssl $(use gnutls && echo "gnutls" || echo "openssl")) \
		$(use_enable ssl opie) \
		$(use_enable ssl digest) \
		$(use_enable idn iri) \
		$(use_enable ipv6) \
		$(use_enable nls) \
		$(use_enable ntlm) \
		$(use_enable debug)
}

src_install() {
	default

	sed -i \
		-e "s:/usr/local/etc:${EPREFIX}/etc:g" \
		"${ED}"/etc/wgetrc \
		"${ED}"/usr/share/man/man1/wget.1 \
		"${ED}"/usr/share/info/wget.info
}
