# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/fromcvs/fromcvs-0_pre132.ebuild,v 1.1 2011/06/16 18:58:34 sochotnicky Exp $

EAPI=2

USE_RUBY="ruby18 ree18"

#mercurial after ruby!
inherit ruby-ng mercurial

MY_PV="${PV#0_pre}"

DESCRIPTION="fromcvs converts cvs to git and hg"
HOMEPAGE="http://ww2.fs.ei.tum.de/~corecode/hg/fromcvs"
SRC_URI=""
EHG_REPO_URI="http://ww2.fs.ei.tum.de/~corecode/hg/fromcvs"
EHG_REVISION="${MY_PV}"

LICENSE="BSD-4"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RUBY_S="${PN}-${PV}"

RDEPEND="dev-ruby/rcsparse >=dev-ruby/rbtree-0.3.0-r2 dev-vcs/git"

# this is a workaround because combination of ruby-ng and mercurial is
# not working correctly for unpacking
src_prepare() {
	for rubyv in ${USE_RUBY};do
		mkdir "${WORKDIR}/${rubyv}"
		cp -prl "${S}" "${WORKDIR}/${rubyv}/${RUBY_S}"
	done
}

each_ruby_install() {
	siteruby=$(${RUBY} -r rbconfig -e 'print Config::CONFIG["sitedir"]')
	insinto ${siteruby}
	doins *.rb || die "Installation of rb files failed"

	make_script togit
	make_script tohg
}

make_script() {
	echo "ruby /usr/$(get_libdir)/ruby/site_ruby/$1.rb \$@" > $1
	dobin $1
}
