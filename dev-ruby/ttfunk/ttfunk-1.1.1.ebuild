# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ttfunk/ttfunk-1.1.1.ebuild,v 1.5 2014/08/12 13:13:08 blueness Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 jruby"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_RECIPE_TEST="rspec"

inherit ruby-fakegem versionator

DESCRIPTION="A TrueType font parser written in pure ruby"
HOMEPAGE="https://github.com/prawnpdf/ttfunk/"
SRC_URI="https://github.com/prawnpdf/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="|| ( GPL-2 GPL-3 Ruby )"
SLOT="$(get_version_component_range 1-2)"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64"
IUSE=""

all_ruby_prepare() {
	sed -i -e '/bundler/I s:^:#:' spec/spec_helper.rb || die
}
