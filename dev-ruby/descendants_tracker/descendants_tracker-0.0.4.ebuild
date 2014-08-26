# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/descendants_tracker/descendants_tracker-0.0.4.ebuild,v 1.2 2014/08/26 20:12:49 blueness Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21"

RUBY_FAKEGEM_RECIPE_TEST="rspec"
RUBY_FAKEGEM_RECIPE_DOC="yard"
RUBY_FAKEGEM_EXTRADOC="README.md"

inherit ruby-fakegem

DESCRIPTION="Module that adds descendant tracking to a class"
HOMEPAGE="https://github.com/dkubb/descendants_tracker"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64"
IUSE=""

all_ruby_prepare() {
	# Remove dependency on devtools
	sed -i -e '/devtools\/spec_helper/d' spec/spec_helper.rb || die
	sed -i -e '/it_should_behave_like/d' \
		spec/unit/descendants_tracker/add_descendant_spec.rb || die
	sed -i -e '/it_should_behave_like/d' \
		spec/unit/descendants_tracker/descendants_spec.rb || die
}
