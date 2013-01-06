# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/guile/guile-1.8.7-r1.ebuild,v 1.1 2010/09/24 12:36:15 jlec Exp $

EAPI=3
inherit eutils autotools flag-o-matic elisp-common

DESCRIPTION="Scheme interpreter"
HOMEPAGE="http://www.gnu.org/software/guile/"
SRC_URI="mirror://gnu/guile/${P}.tar.gz"

LICENSE="LGPL-2.1"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="networking +regex discouraged +deprecated elisp emacs nls debug-freelist debug-malloc debug +threads"
RESTRICT="!regex? ( test )"

DEPEND="
	>=dev-libs/gmp-4.1
	>=sys-devel/libtool-1.5.6
	sys-devel/gettext
	emacs? ( virtual/emacs )"
RDEPEND="${DEPEND}"

# Guile seems to contain some slotting support, /usr/share/guile/ is slotted,
# but there are lots of collisions. Most in /usr/share/libguile. Therefore
# I'm slotting this in the same slot as guile-1.6* for now.
SLOT="12"
MAJOR="1.8"

src_prepare() {
	sed "s_sleep 999_sleep 1_" -i test-suite/tests/popen.test
	epatch "${FILESDIR}/${P}-fix_tests.patch"
	epatch "${FILESDIR}"/${P}-gcc45.patch  # 317175

#	cp configure.in configure.in.old

	#for libtool-2.2*, bug 212723
#	sed 's/AC_CONFIG_MACRO_DIR(\[m4\])/AC_CONFIG_MACRO_DIR(\[guile-config\])/' -i configure.in

#	diff -u configure.in.old configure.in

	eautoreconf
}

src_configure() {
	# see bug #178499
	filter-flags -ftree-vectorize

	#will fail for me if posix is disabled or without modules -- hkBst
	econf \
		--disable-error-on-warning \
		--disable-static \
		--enable-posix \
		$(use_enable networking) \
		$(use_enable regex) \
		$(use deprecated || use_enable discouraged) \
		$(use_enable deprecated) \
		$(use_enable elisp) \
		$(use_enable nls) \
		--disable-rpath \
		$(use_enable debug-freelist) \
		$(use_enable debug-malloc) \
		$(use_enable debug guile-debug) \
		$(use_with threads) \
		--with-modules \
		EMACS=no
}

src_compile()  {
	emake || die "make failed"

	# Above we have disabled the build system's Emacs support;
	# for USE=emacs we compile (and install) the files manually
	if use emacs; then
		cd emacs
		elisp-compile *.el || die
	fi
}

src_install() {
	einstall || die "install failed"

	dodoc AUTHORS ChangeLog GUILE-VERSION HACKING NEWS README THANKS || die

	# texmacs needs this, closing bug #23493
	dodir /etc/env.d
	echo "GUILE_LOAD_PATH=\"${EPREFIX}/usr/share/guile/${MAJOR}\"" > "${ED}"/etc/env.d/50guile

	# necessary for registering slib, see bug 206896
	keepdir /usr/share/guile/site

	if use emacs; then
		elisp-install ${PN} emacs/*.{el,elc} || die
		elisp-site-file-install "${FILESDIR}/50${PN}-gentoo.el" || die
	fi
}

pkg_postinst() {
	[ "${EROOT}" == "/" ] && pkg_config
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}

pkg_config() {
	if has_version dev-scheme/slib; then
		einfo "Registering slib with guile"
		install_slib_for_guile
	fi
}

_pkg_prerm() {
	rm -f "${EROOT}"/usr/share/guile/site/slibcat
}
