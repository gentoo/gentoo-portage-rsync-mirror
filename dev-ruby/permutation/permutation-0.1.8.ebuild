# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/permutation/permutation-0.1.8.ebuild,v 1.1 2013/12/25 16:57:52 naota Exp $

EAPI=5

USE_RUBY="ruby19 ruby20"
RUBY_FAKEGEM_RECIPE_TEST="rake"
RUBY_FAKEGEM_RECIPE_DOC="rake"
RUBY_FAKEGEM_TASK_DOC="doc"

inherit multilib ruby-fakegem

DESCRIPTION="Library to perform different operations with permutations of sequences (strings, arrays, etc.)"
HOMEPAGE="http://flori.github.com/permutation"

LICENSE="|| ( Ruby-BSD BSD-2 )"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"
