# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/fontconfig/fontconfig-2.10.92.ebuild,v 1.7 2013/08/26 16:56:13 ago Exp $

EAPI=5
AUTOTOOLS_AUTORECONF=yes

inherit autotools-multilib readme.gentoo

DESCRIPTION="A library for configuring and customizing font access"
HOMEPAGE="http://fontconfig.org/"
SRC_URI="http://fontconfig.org/release/${P}.tar.bz2"

LICENSE="MIT"
SLOT="1.0"
KEYWORDS="~alpha ~amd64 ~arm hppa ~ia64 ~m68k ~mips ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~amd64-linux ~arm-linux ~x86-linux"
IUSE="doc static-libs"

# Purposefully dropped the xml USE flag and libxml2 support.  Expat is the
# default and used by every distro.  See bug #283191.

RDEPEND=">=dev-libs/expat-1.95.3[${MULTILIB_USEDEP}]
	>=media-libs/freetype-2.2.1[${MULTILIB_USEDEP}]
	abi_x86_32? ( !app-emulation/emul-linux-x86-xlibs[-abi_x86_32(-)] )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? (
		=app-text/docbook-sgml-dtd-3.1*
		app-text/docbook-sgml-utils[jadetex]
	)"
PDEPEND="app-admin/eselect-fontconfig
	virtual/ttf-fonts"

PATCHES=(
	"${FILESDIR}"/${PN}-2.7.1-latin-reorder.patch	# 130466
	"${FILESDIR}"/${PN}-2.10.2-docbook.patch	# 310157
	# Apply upstream patches that will be included in 2.10.93
	"${FILESDIR}"/${P}-native-fonts.patch
	"${FILESDIR}"/${P}-automake-1.13.patch
	"${FILESDIR}"/${P}-closing-fp.patch
	"${FILESDIR}"/${P}-ft-face.patch
	"${FILESDIR}"/${P}-ft-face2.patch
	"${FILESDIR}"/${P}-fix-check.patch
	"${FILESDIR}"/${P}-use-glob.patch
)

pkg_setup() {
	DOC_CONTENTS="Please make fontconfig configuration changes using
	\`eselect fontconfig\`. Any changes made to /etc/fonts/fonts.conf will be
	overwritten. If you need to reset your configuration to upstream defaults,
	delete the directory ${EROOT}etc/fonts/conf.d/ and re-emerge fontconfig."
}

src_configure() {
	local myeconfargs=(
		$(use_enable doc docbook)
		# always enable docs to install manpages
		--enable-docs
		--localstatedir="${EPREFIX}"/var
		--with-default-fonts="${EPREFIX}"/usr/share/fonts
		--with-add-fonts="${EPREFIX}"/usr/local/share/fonts
		--with-templatedir="${EPREFIX}"/etc/fonts/conf.avail
	)

	autotools-multilib_src_configure
}

src_install() {
	autotools-multilib_src_install

	# XXX: avoid calling this multiple times, bug #459210
	install_others() {
		# stuff installed from build-dir
		autotools-utils_src_compile \
			DESTDIR="${D}" -C doc install-man

		insinto /etc/fonts
		doins "${BUILD_DIR}"/fonts.conf
	}
	multilib_foreach_abi install_others

	#fc-lang directory contains language coverage datafiles
	#which are needed to test the coverage of fonts.
	insinto /usr/share/fc-lang
	doins fc-lang/*.orth

	dodoc doc/fontconfig-user.{txt,pdf}

	if [[ -e ${ED}usr/share/doc/fontconfig/ ]];  then
		mv "${ED}"usr/share/doc/fontconfig/* "${ED}"/usr/share/doc/${P}
		rm -rf "${ED}"usr/share/doc/fontconfig
	fi

	# Changes should be made to /etc/fonts/local.conf, and as we had
	# too much problems with broken fonts.conf we force update it ...
	echo 'CONFIG_PROTECT_MASK="/etc/fonts/fonts.conf"' > "${T}"/37fontconfig
	doenvd "${T}"/37fontconfig

	# As of fontconfig 2.7, everything sticks their noses in here.
	dodir /etc/sandbox.d
	echo 'SANDBOX_PREDICT="/var/cache/fontconfig"' > "${ED}"/etc/sandbox.d/37fontconfig

	readme.gentoo_create_doc
}

pkg_preinst() {
	# Bug #193476
	# /etc/fonts/conf.d/ contains symlinks to ../conf.avail/ to include various
	# config files.  If we install as-is, we'll blow away user settings.
	ebegin "Syncing fontconfig configuration to system"
	if [[ -e ${EROOT}/etc/fonts/conf.d ]]; then
		for file in "${EROOT}"/etc/fonts/conf.avail/*; do
			f=${file##*/}
			if [[ -L ${EROOT}/etc/fonts/conf.d/${f} ]]; then
				[[ -f ${ED}etc/fonts/conf.avail/${f} ]] \
					&& ln -sf ../conf.avail/"${f}" "${ED}"etc/fonts/conf.d/ &>/dev/null
			else
				[[ -f ${ED}etc/fonts/conf.avail/${f} ]] \
					&& rm "${ED}"etc/fonts/conf.d/"${f}" &>/dev/null
			fi
		done
	fi
	eend $?
}

pkg_postinst() {
	einfo "Cleaning broken symlinks in "${EROOT}"etc/fonts/conf.d/"
	find -L "${EROOT}"etc/fonts/conf.d/ -type l -delete

	readme.gentoo_print_elog

	if [[ ${ROOT} = / ]]; then
		ebegin "Creating global font cache"
		"${EPREFIX}"/usr/bin/fc-cache -srf
		eend $?
	fi
}
