# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/eix/eix-0.29.3.ebuild,v 1.9 2013/09/05 13:27:27 ago Exp $

EAPI=5

PLOCALES="de ru"
inherit bash-completion-r1 eutils multilib l10n

DESCRIPTION="Search and query ebuilds, portage incl. local settings, ext. overlays, version changes, and more"
HOMEPAGE="http://eix.berlios.de"
SRC_URI="mirror://berlios/${PN}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~m68k ~mips ppc ppc64 ~s390 ~sh ~sparc x86 ~ppc-aix ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~x86-freebsd ~ia64-hpux ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x86-solaris"
IUSE="clang debug +dep doc nls optimization security strong-optimization strong-security sqlite swap-remote tools zsh-completion"

BOTHDEPEND="sqlite? ( >=dev-db/sqlite-3 )
	nls? ( virtual/libintl )"
RDEPEND="${BOTHDEPEND}
	app-shells/push"
DEPEND="${BOTHDEPEND}
	app-arch/xz-utils
	clang? ( sys-devel/clang )
	nls? ( sys-devel/gettext )"

pkg_setup() {
	case " ${REPLACING_VERSIONS}" in
	*\ 0.[0-9].*|*\ 0.1[0-9].*|*\ 0.2[0-4].*|*\ 0.25.0*)
		local eixcache="${EROOT}/var/cache/${PN}"
		test -f "${eixcache}" && rm -f -- "${eixcache}";;
	esac
}

src_prepare() {
	epatch_user
}

src_configure() {
	econf $(use_with sqlite) $(use_with doc extra-doc) \
		$(use_with zsh-completion) \
		$(use_enable nls) $(use_enable tools separate-tools) \
		$(use_enable security) $(use_enable optimization) \
		$(use_enable strong-security) \
		$(use_enable strong-optimization) $(use_enable debug debugging) \
		$(use_enable swap-remote) \
		$(use_with prefix always-accept-keywords) \
		$(use_with dep dep-default) \
		$(use_with clang nongnu-cxx clang++) \
		--with-ebuild-sh-default="/usr/$(get_libdir)/portage/bin/ebuild.sh" \
		--with-portage-rootpath="${ROOTPATH}" \
		--with-eprefix-default="${EPREFIX}" \
		--docdir="${EPREFIX}/usr/share/doc/${PF}" \
		--htmldir="${EPREFIX}/usr/share/doc/${PF}/html"
}

src_install() {
	default
	dobashcomp bash/eix
	keepdir "/var/cache/${PN}"
	fowners portage:portage "/var/cache/${PN}"
	fperms 775 "/var/cache/${PN}"
}

pkg_postinst() {
	# fowners in src_install doesn't work for owner/group portage:
	# merging changes this owner/group back to root.
	use prefix || chown portage:portage "${EROOT}var/cache/${PN}"
	local obs="${EROOT}var/cache/eix.previous"
	! test -f "${obs}" || ewarn "Found obsolete ${obs}, please remove it"
}
