# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/org-ruby/org-ruby-0.8.2.ebuild,v 1.1 2013/12/13 04:17:44 mrueg Exp $

EAPI=5
USE_RUBY="ruby19"

RUBY_FAKEGEM_RECIPE_TEST="rspec"
RUBY_FAKEGEM_RECIPE_DOC="none"
RUBY_FAKEGEM_EXTRADOC="README.rdoc History.txt"

inherit ruby-fakegem

DESCRIPTION="Ruby routines for parsing org-mode files"
HOMEPAGE="https://github.com/bdewey/org-ruby"
SRC_URI="https://github.com/bdewey/${PN}/archive/version-${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RUBY_S="${PN}-version-${PV}"

ruby_add_rdepend "dev-ruby/rubypants"
ruby_add_bdepend "test? ( dev-ruby/tilt )"
