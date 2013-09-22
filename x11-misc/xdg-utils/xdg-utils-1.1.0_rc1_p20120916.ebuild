# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xdg-utils/xdg-utils-1.1.0_rc1_p20120916.ebuild,v 1.2 2013/09/22 01:59:37 heroxbd Exp $

# See .spec in http://pkgs.fedoraproject.org/gitweb/?p=xdg-utils.git;a=summary
# The source tree MUST be cleaned before rolling a snapshot tarball:
# make scripts-clean -C scripts
# make man scripts -C scripts

EAPI=4

DESCRIPTION="Portland utils for cross-platform/cross-toolkit/cross-desktop interoperability"
HOMEPAGE="http://portland.freedesktop.org/"
SRC_URI="http://dev.gentoo.org/~ssuominen/${P/0823/2308}.tar.xz -> ${P}.tar.xz" # typo :(
#SRC_URI="http://portland.freedesktop.org/download/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="doc +perl"

RDEPEND="dev-util/desktop-file-utils
	x11-misc/shared-mime-info
	x11-apps/xprop
	x11-apps/xset
	perl? ( dev-perl/File-MimeInfo )"
DEPEND=""
#app-text/xmlto || ( www-client/links www-client/lynx virtual/w3m )

DOCS="ChangeLog README RELEASE_NOTES TODO"

RESTRICT="test" # Disabled because of sandbox violation(s)

S=${WORKDIR}/${P/0823/2308}

#src_prepare() {
#	emake scripts-clean -C scripts
#}
#
#src_compile() {
#	emake man scripts -C scripts
#}

src_install() {
	default

	newdoc scripts/README README.scripts
	use doc && dohtml -r scripts/html

	# Install default XDG_DATA_DIRS, bug #264647
	echo XDG_DATA_DIRS=\"${EPREFIX}/usr/local/share\" > 30xdg-data-local
	echo 'COLON_SEPARATED="XDG_DATA_DIRS XDG_CONFIG_DIRS"' >> 30xdg-data-local
	doenvd 30xdg-data-local

	echo XDG_DATA_DIRS=\"${EPREFIX}/usr/share\" > 90xdg-data-base
	echo XDG_CONFIG_DIRS=\"${EPREFIX}/etc/xdg\" >> 90xdg-data-base
	doenvd 90xdg-data-base
}

pkg_postinst() {
	[[ -x $(type -P gtk-update-icon-cache) ]] || elog "Install x11-libs/gtk+:2 for the gtk-update-icon-cache command."
}
