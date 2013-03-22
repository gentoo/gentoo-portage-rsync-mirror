# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-python/eselect-python-99999999.ebuild,v 1.9 2013/03/22 03:25:53 vapier Exp $

# Keep the EAPI low here because everything else depends on it.
# We want to make upgrading simpler.

if [[ ${PV} == "99999999" ]] ; then
	EGIT_REPO_URI="git://git.overlays.gentoo.org/proj/${PN}.git"
	inherit autotools git-2
else
	SRC_URI="mirror://gentoo/${P}.tar.bz2"
	KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd"
fi

DESCRIPTION="Eselect module for management of multiple Python versions"
HOMEPAGE="http://www.gentoo.org/proj/en/Python/"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND=">=app-admin/eselect-1.2.3"
# Avoid autotool deps for released versions for circ dep issues.
if [[ ${PV} == "99999999" ]] ; then
	DEPEND="sys-devel/autoconf"
else
	DEPEND=""
fi

src_unpack() {
	if [[ ${PV} == "99999999" ]] ; then
		git-2_src_unpack
		cd "${S}"
		eautoreconf
	else
		unpack ${A}
	fi
}

src_install() {
	keepdir /etc/env.d/python
	emake DESTDIR="${D}" install || die
}

pkg_postinst() {
	local ret=0
	ebegin "Running 'eselect python update'"
	eselect python update --python2 --if-unset || ret=1
	eselect python update --python3 --if-unset || ret=1
	eend ${ret}
}
